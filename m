Return-Path: <linux-kernel+bounces-36710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EDF83A551
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C562898EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FC17C95;
	Wed, 24 Jan 2024 09:22:57 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458C17BDF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088176; cv=none; b=Mpp2WeBNYCffyUZPJ7gqma2Nldwmz6lrLp7ivh5LzcAmXITbJw+Udc6szN/mHK2z33E9zokZ6NKRbGbwwSFHW4tV2T4DZ2MT1g6g49ieqVxAujuP8H1gXpU3UgHFh/V0J48khuouzLvYxVoti21l8FcL7RRYposxAFOKC//sKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088176; c=relaxed/simple;
	bh=2WWb4KcePbKUck8UKIAk5VLZUPdP8DDf3RPHxMAE4RU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pzg3KBD1aHEJK/zjBpniIfz4BuL6uUHffS2nuVdkVc6qvlmJ4Zg9HxKYDjze0vZ4AFAWrKW0TUKb9S0bU0FYQdBgCpZzev31MTMLa30epGYPzgRH/HSVkfkNjL6XWZYeVmEwz+zxhxeaVIfIKYV7e9sBqglfjY4twNiNooQAScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2976164507DA;
	Wed, 24 Jan 2024 10:22:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id w_Bvcet4ViWp; Wed, 24 Jan 2024 10:22:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A16ED64507E4;
	Wed, 24 Jan 2024 10:22:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u8S5ND4jULSw; Wed, 24 Jan 2024 10:22:50 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 6809B64507DA;
	Wed, 24 Jan 2024 10:22:50 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH] MAINTAINERS: Add Zhihao Cheng as UBI/UBIFS reviewer
Date: Wed, 24 Jan 2024 10:22:46 +0100
Message-Id: <20240124092246.9616-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recognizing Zhihao Cheng's valuable contributions,
let's officially appoint him as a UBI/UBIFS reviewer.
His demonstrated expertise and assistance make him a valuable
addition to the MTD community.

Cc: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
Zhihao Cheng,

Please ack this patch if you're fine with this change.

Thanks,
//richard
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..fc99cc381268 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22453,6 +22453,7 @@ F:	include/uapi/misc/uacce/
=20
 UBI FILE SYSTEM (UBIFS)
 M:	Richard Weinberger <richard@nod.at>
+R:	Zhihao Cheng <chengzhihao1@huawei.com>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
@@ -22581,6 +22582,7 @@ F:	drivers/ufs/host/ufs-renesas.c
=20
 UNSORTED BLOCK IMAGES (UBI)
 M:	Richard Weinberger <richard@nod.at>
+R:	Zhihao Cheng <chengzhihao1@huawei.com>
 L:	linux-mtd@lists.infradead.org
 S:	Supported
 W:	http://www.linux-mtd.infradead.org/
--=20
2.35.3


