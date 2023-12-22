Return-Path: <linux-kernel+bounces-9636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0C81C8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CD41F23746
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4750D17995;
	Fri, 22 Dec 2023 11:08:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m17238.xmail.ntesmail.com (mail-m17238.xmail.ntesmail.com [45.195.17.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEF17992
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [10.9.0.94] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BEF3A4C0174;
	Fri, 22 Dec 2023 19:08:09 +0800 (CST)
Message-ID: <5a791f12-9c88-4dca-ac9d-dee4ba36bf9c@easystack.cn>
Date: Fri, 22 Dec 2023 19:08:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kexec: Fix potential out of bounds in
 crash_exclude_mem_range()
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-3-fuqiang.wang@easystack.cn>
 <ZYQknSaxtNt/ZQvI@MiWiFi-R3L-srv>
Content-Language: en-US
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZYQknSaxtNt/ZQvI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUhNVk1CSElOHUMfSk1LQ1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c9136165c022ekunmbef3a4c0174
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Qgw5Hjc#ISgKAhE9NR4B
	MBcKCUNVSlVKTEtISU9ISUJLTk9DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFKQ0NMNwY+


在 2023/12/21 19:42, Baoquan He 写道:
> You may need rebase your work on next/master branch to avoid conflict.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
> In the current, below commit exists, then code change in this patch may
> not be needed.
> 86d80cbb61ca crash_core: fix and simplify the logic of crash_exclude_mem_range()
>

Yes, Baoquan, you are right. It's my mistake. Thank you very much ~


