Return-Path: <linux-kernel+bounces-10465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033681D4B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EA41C2105D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938C10979;
	Sat, 23 Dec 2023 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="TTYeuNlh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA701095C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rH3DA-0006xy-Q6; Sat, 23 Dec 2023 09:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=zcLtU8M+MnEcP+pBkyqzvLSixRbpUKiBom9krQC91lw=; b=TTYeuNlhQsJkFp
	VYsAdu0bAaYAys7ou0RwQxoksr8gF43z9vzVCDju41g/NqDPBL7rTHBT8VnLSN3lPaZHDp/MWEpp1
	6PtO0OLfRXtKiTgmZLwsk1R855eSMNVCW25gTnyDp3KRoiLzZjMkhX1YWrsskSLanQkWdIGwat4ag
	JQxm6JdhfNTAYKOPSuTBQ97si7yFc1resMqk5SOs3rpc/sl7hIJhe1nUxvjeYOiw7j3iPHFw8EapR
	0on0X6D0+viUy/QNLsqdYlJeFgglrHZD1mJqwvmmqxPekeo+zSiyjyKoyk+HVT39Miqjs9SC4Qc3J
	e0xsBQTS75/ODWAU8Saw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Mathieu Othacehe <othacehe@gnu.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add entries for Mathieu Othacehe
Date: Sat, 23 Dec 2023 15:42:22 +0100
Message-ID: <20231223144226.25740-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add my gnu.org mail address.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a77bbbf1babd..44d3fe4c1454 100644
--- a/.mailmap
+++ b/.mailmap
@@ -377,7 +377,7 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
-Mathieu Othacehe <m.othacehe@gmail.com>
+Mathieu Othacehe <m.othacehe@gmail.com> <othacehe@gnu.org>
 Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
 Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
-- 
2.41.0


