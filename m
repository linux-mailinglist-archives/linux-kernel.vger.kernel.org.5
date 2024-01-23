Return-Path: <linux-kernel+bounces-35632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2952A83945D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A85EB2970A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B666B35;
	Tue, 23 Jan 2024 16:10:32 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD46BB49;
	Tue, 23 Jan 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026231; cv=none; b=l6GWyYYns4qo1Me12k29iQ19v6Gyk5cSziTAZzcgCWSKrxRLn8ocSqBzQcFJcAw7yIpdwsstQJu+DPgANioOHZnpbZzuZGy2SaorOJKarBJbFSb97meEt6HpIJkxXCvCPYbQdxEsXCCqYrvh6cUlqbP5bC31WofxgnNFiRTyjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026231; c=relaxed/simple;
	bh=/mPIgHq0w2qaUMGCkrU3Cu6bC9EjioKbpcWgTPzL5UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9KDQn2kAzNhHvOl8qG7ZJJotA/lEi7d1JCKOHR6/Iy9r5vWbRTej3q/lRnf4Khsa/npiU7Ysvm8j+nWjCaICZ5GAmCxEYoC4dGaRBEW+A3E7xdvcm+rhGBbNOsKeP4kWFg1H39/gZQo9WqZoUlKfn6CoijcFEtyYrCdBPjgm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdNTy-1qsyXF1lWC-00ZQ6l; Tue, 23 Jan 2024 17:10:21 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] rust: locked_by: shorten doclink preview
Date: Tue, 23 Jan 2024 17:10:20 +0100
Message-ID: <20240123161020.125411-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
References: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A78h7VEK/k0EYoCiEAC98WH3nnSRQhqfYYEbV0l8MCjBxERCtaC
 Dw33gAcdWFNUwuUVkFaKlRJe5jplKvWAuxwWqh0KWV/AgaN50QxkxRiOgBqzkSSVaft2gGG
 97wn9jLETO+PUITmJYzOssTtk3EHQski3H25nQeO4XbUmZwHa7k0ywdMUnqUKFttXT3MyOP
 ShYzJYxLuO2X/z+WtA+gA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EDVxGzJZ4fo=;VNkoZV4Qh5i2B3D7njue7EoaVhb
 uW5IbeOXK9xEDkU2o+nPhw+W3romeRdnBVj5mrbMHxcgaVRDt6h2ypvbaQCUfceyZKZ1JyMOV
 spOBvIwS0xLmaKzrPZpBL7WK4U3hQzzAp5IgrTxhwwpFoYJu36UaowOjlfWhDeWZ0YKDdrUMM
 eaALDZiRCDmONzSzb4fij4gFgRiVzICfi29mz4+SKajFB0iSB5lNKdMeclvdKMzK/d/dUtPYM
 mQGZ78zWP4dhQI2cMjzxW2hXyF+hwkIysCqr4sUAcdxABYjKx0LkSwC9nlFv+jmpcfrZ1SekF
 1WP+84mlL+xHLxcQj4xKMts3z5aFdGeqk5zS0S5aGrQQtTY6iBQyo7DqSUR1LohFnUZP7vC9t
 o14LIg2AYIyAB4kcIzNNLjaQA1FgGn8rZhQeRQBdv8OZn3TgXeQbC+sUuXu3h3J6IJ705XQLS
 iUnoa3jZmj0zyTG4WdDe1DXh1nkPlF3a0kNOrJa+3CDRj7WyIwftnx5FDuhCr/89x78hamK7l
 dgI+tsQMGr3Mi9Nz720mD4w9iFFAp+ymychP8+OrB+iZS4LhlIIObIDjnkpBNHgu/OgDWbzbB
 CCPh0ED9+mL5ufHa8chayac0TzIUV+bshLMgFRX5Ov6aSVQz2cWV0KEo9k57cA9b4ItpaNWLi
 igeMuNB3sRvzhoIWfZqWZDT07rM61cwWMiGSImlOFpTAyxEYfQU57MnOShrebBuGJduZhavPI
 XyLd2FPBwuwRUiVZK8ldx2S4cpSdpKTicfariPCBNkRurpYjn20BvEETHM/hWymPP15QDb6Vd
 Qvdp4QxS+Ye3uK6BclxFy6qXenGE2zWiYJkraCfZ3CksoTBKgRD9NJG9HueYsD/MMmya+sLQ8
 s8IOtxGWsjy2C/Q==

Increases readability by removing `super::` from the link preview
text.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/sync/locked_by.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index b17ee5cd98f3..22c38993bf63 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -9,7 +9,7 @@
 /// Allows access to some data to be serialised by a lock that does not wrap it.
 ///
 /// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
-/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
+/// [`Mutex`] or [`SpinLock`]. [`LockedBy`] is meant for cases when this is not
 /// possible. For example, if a container has a lock and some data in the contained elements needs
 /// to be protected by the same lock.
 ///
@@ -17,6 +17,9 @@
 /// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
 /// refers to the wrong instance of the lock.
 ///
+/// [`Mutex`]: super::Mutex
+/// [`SpinLock`]: super::SpinLock
+///
 /// # Examples
 ///
 /// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
-- 
2.43.0


