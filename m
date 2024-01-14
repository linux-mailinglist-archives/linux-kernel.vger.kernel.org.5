Return-Path: <linux-kernel+bounces-25460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D282D0A1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A221F218CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAC2113;
	Sun, 14 Jan 2024 12:48:48 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5720EE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.245])
	by sina.com (172.16.235.25) with ESMTP
	id 65A3D7FB0000159E; Sun, 14 Jan 2024 20:47:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 51801234210117
X-SMAIL-UIID: B27419112364487C8E0145EB14C64608-20240114-204757-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9877b6999a2554291c7d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in ni_readpage_cmpr
Date: Sun, 14 Jan 2024 20:47:45 +0800
Message-Id: <20240114124745.773-1-hdanton@sina.com>
In-Reply-To: <000000000000ca751d0600f457c3@google.com>
References: <000000000000ca751d0600f457c3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Jul 2023 17:28:25 -0700
> HEAD commit:    7c2878be5732 Add linux-next specific files for 20230714
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170ad732a80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

