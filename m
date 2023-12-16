Return-Path: <linux-kernel+bounces-2100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721868157DC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270001F25E08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363614009;
	Sat, 16 Dec 2023 05:46:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A613FEA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.121])
	by sina.com (10.75.12.45) with ESMTP
	id 657D387700007DB0; Sat, 16 Dec 2023 13:41:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 44929931457797
X-SMAIL-UIID: FF289DCFB394463EB4BDFC300F0E4A6A-20231216-134114-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
Date: Sat, 16 Dec 2023 13:41:06 +0800
Message-Id: <20231216054106.1572-1-hdanton@sina.com>
In-Reply-To: <000000000000098af2060b5ff161@google.com>
References: <000000000000098af2060b5ff161@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

