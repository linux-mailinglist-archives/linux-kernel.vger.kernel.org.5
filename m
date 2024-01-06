Return-Path: <linux-kernel+bounces-18516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A6825E87
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E107B22C26
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B733C15;
	Sat,  6 Jan 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fPY0SbxM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611A3C3B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TqNHSUYA6sM9H01tReCTGLhW5nBEUnAS7xmyhZeLS9Y=; b=fPY0SbxMiQXHm7SQxROTgpC+al
	eKSm0CXpMFMGm9A0gI/RRdFhiQoB9bJtTLJ91OwjU9rrDchPZqmDtM0iNdUOlvfww77KFC+99d8d7
	WLYMV2R5DgHa2QGSS8ZRYCt6ihWswvhjRUIKCq6VWn8rVM31uTrv5gzEvSx3foCqpGLAs8lI/j/vA
	IEOFP/wSHW5AP9lruPhPVSdM9uqhjKD4QQc+svybhrSKJ+z1p4acTjR4Xlxa8VMXOsjUcROROiVjO
	m8lSF7AV2kgfHc9NanBzhmjGUUwXwYD8oF9ntkKCk+djJe03K69GKjmk11NJp+IS+KEczS+mtM51x
	Wj6zsUlw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rM0Cq-000qTD-08;
	Sat, 06 Jan 2024 06:30:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mailmap: add old address mappings for myself
Date: Fri,  5 Jan 2024 22:30:44 -0800
Message-ID: <20240106063051.13623-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add my old email addresses so that git send-email will map them
to my current email address.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .mailmap |    3 +++
 1 file changed, 3 insertions(+)

diff -- a/.mailmap b/.mailmap
--- a/.mailmap
+++ b/.mailmap
@@ -505,6 +505,9 @@ Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
 Ram Chandra Jangir <quic_rjangir@quicinc.com> <rjangir@codeaurora.org>
 Randy Dunlap <rdunlap@infradead.org> <rdunlap@xenotime.net>
+Randy Dunlap <rdunlap@infradead.org> <randy.dunlap@oracle.com>
+Randy Dunlap <rdunlap@infradead.org> <rddunlap@osdl.org>
+Randy Dunlap <rdunlap@infradead.org> <randy.dunlap@intel.com>
 Ravi Kumar Bokka <quic_rbokka@quicinc.com> <rbokka@codeaurora.org>
 Ravi Kumar Siddojigari <quic_rsiddoji@quicinc.com> <rsiddoji@codeaurora.org>
 Rémi Denis-Courmont <rdenis@simphalempin.com>

