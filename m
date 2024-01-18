Return-Path: <linux-kernel+bounces-29935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1138831560
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25792B24BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F3313ADC;
	Thu, 18 Jan 2024 09:03:10 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF012B6B;
	Thu, 18 Jan 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568589; cv=none; b=pSJvdR1Pjxd37AGxXkYZZi2p0c0CUQUtwnXyRrMTOV54Sqx/hUnmNIbCjwbGMhefo0bBfjqs4iOoPufJWZIt17yVYXtJde3aLkfT4VF3759ZJ3w2iwD45e9BNGh0k1DjJztnIypZ4jpivaG4HGlcjuOiPxOscIbOJmJnnQcL7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568589; c=relaxed/simple;
	bh=xlWjwwxipA/OAGarR0Lfw8YUWtEwQZahaBwy940YNlw=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Spam-Status:X-HM-Tid:X-HM-MType:
	 X-HM-Sender-Digest; b=lo+IimETG/whMra1q2f8vOsB6Wnq/nU3fPdZs+tuvlnrepqy3ElNNEgOxuOamcW3S10w4IpDMjofXRj3yHOfV0fsRwva1pdYkuAo1Z+Ct5ALtH84A7mBOWBmoPy6FeN3DonxVK9fECSs2mmLm55FuJ7x3XRy91HTILFi99iP6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn; spf=pass smtp.mailfrom=link.tyut.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=link.tyut.edu.cn
Received: from localhost.localdomain (unknown [IPV6:2409:8a0c:261:c560:6481:a5f4:f907:1ca0])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 242BC8000B2;
	Thu, 18 Jan 2024 17:02:38 +0800 (CST)
From: Hu Haowen <2023002089@link.tyut.edu.cn>
To: ogabbay@kernel.org,
	corbet@lwn.net
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/accel: correct links to mailing list archives
Date: Thu, 18 Jan 2024 17:01:40 +0800
Message-Id: <20240118090140.4868-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHRlJVkgaGh0dHUkeTE8aS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPS0JBQxpLGEFJTUpBGE5NS0FNT0NKQRpOHU9BHUJLTEFKGBpLWVdZFhoPEhUdFF
	lBWUtVS1VLVUtZBg++
X-HM-Tid: 0a8d1bcedd14b03akuuu242bc8000b2
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46SQw6IzwvKhANDj4vOBIR
	DBEKClFVSlVKTEtOTk1DTk5CSE1LVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
	V1kSC1lBWUlPS0JBQxpLGEFJTUpBGE5NS0FNT0NKQRpOHU9BHUJLTEFKGBpLWVdZCAFZQUpCTkk3
	Bg++

Since the mailing archive list lkml.org is obsolete, change the links into
lore.kernel.org's ones.

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 Documentation/accel/introduction.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/accel/introduction.rst b/Documentation/accel/introduction.rst
index 89984dfececf..ae3030136637 100644
--- a/Documentation/accel/introduction.rst
+++ b/Documentation/accel/introduction.rst
@@ -101,8 +101,8 @@ External References
 email threads
 -------------
 
-* `Initial discussion on the New subsystem for acceleration devices <https://lkml.org/lkml/2022/7/31/83>`_ - Oded Gabbay (2022)
-* `patch-set to add the new subsystem <https://lkml.org/lkml/2022/10/22/544>`_ - Oded Gabbay (2022)
+* `Initial discussion on the New subsystem for acceleration devices <https://lore.kernel.org/lkml/CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com/>`_ - Oded Gabbay (2022)
+* `patch-set to add the new subsystem <https://lore.kernel.org/lkml/20221022214622.18042-1-ogabbay@kernel.org/>`_ - Oded Gabbay (2022)
 
 Conference talks
 ----------------
-- 
2.34.1


