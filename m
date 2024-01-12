Return-Path: <linux-kernel+bounces-24255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268482B9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7381B25013
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007531848;
	Fri, 12 Jan 2024 03:00:48 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CB111B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-RP1u7_1705028435;
Received: from 30.221.128.149(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W-RP1u7_1705028435)
          by smtp.aliyun-inc.com;
          Fri, 12 Jan 2024 11:00:36 +0800
Message-ID: <40cbc1a6-9905-4bfc-8918-bd4f4c686166@linux.alibaba.com>
Date: Fri, 12 Jan 2024 11:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] relay: avoid relay_open_buf inproperly fails in
 buffer-only mode
From: Philo Lu <lulie@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, surenb@google.com, rppt@kernel.org,
 zhou.kete@h3c.com, zhao_lei1@hoperun.com, kunyu@nfschina.com,
 zhang.zhengming@h3c.com, gregkh@linuxfoundation.org,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com, hengqi@linux.alibaba.com
References: <20231220074725.23211-1-lulie@linux.alibaba.com>
 <3b2805c0-daa1-4d2f-a3b3-4376a51ab219@linux.alibaba.com>
In-Reply-To: <3b2805c0-daa1-4d2f-a3b3-4376a51ab219@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Is there any feedback about this patch?

Many thanks for your time.

