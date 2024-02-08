Return-Path: <linux-kernel+bounces-58512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A884E75B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5980928365E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F0129A93;
	Thu,  8 Feb 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhoL6Cm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE786132;
	Thu,  8 Feb 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415488; cv=none; b=rlViRyWj5x4O55c8+0TDcmSj2TOrZ0P0zyEa6d4DE8nEYvIECxznF7HJOhjftTSMXXsTc/xc9MoDijmW0A9UDc5cSwJ1XKakPrDgeg5Rk2yPDQXYNAyk7iLEB9cVidohTLgPYA5qoRmldENQDT4fG3U5i02fg7c1PORGpCvb8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415488; c=relaxed/simple;
	bh=3Uhrwe4sRvrwINsS64MrEMTgrGNb4S7Ahy2QqbR4f0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0ubRPsFx7QfgAfmamB0kvVaf2NThr8WbPoPSpoqD9azJhozzIeXKi4agGORm1rMoJscsOJ8lhm4LPNFJ0BA669b9F/GJ9kMEVYJhd04zR+iRWyWop4e2/DhlFjZeojrYAtM5D15gVcEl1TyKou0bgnZfqctX/X5/+Q49sLIdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhoL6Cm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E80DC43399;
	Thu,  8 Feb 2024 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415488;
	bh=3Uhrwe4sRvrwINsS64MrEMTgrGNb4S7Ahy2QqbR4f0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UhoL6Cm5ieWcXeo8f3wJo/Me6dy0QuAxDjlVGWEoAH+fs64ZU02V+5+Fj0k2eAkwF
	 BYSNB5k4bywcbzwIOnDhqk9Dv0/aNzw36wtrHkEdVttsCDu7HMqdPa6xSHxGoO/yZI
	 LcDj3OOmkJUUckY79T4UUKhJC9pP9LLhQ1/kLOJX6E/FitqpQH7Ee7C/YWMAEAjTwX
	 k1ZpeRL25RN3fDrn8VEKpiHY8OmF3340jlfEc27+W0DVG0VJfkcyK5PNGOeKrHNPVy
	 b/ns23XurVR8BA/HL0bUJWFwHIUnuP8aqeg8GacwiQl+22sOYjSGsL3tOx2GuLDDAs
	 5cMd3bn2pkR6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:55 +0100
Subject: [PATCH net 7/7] MAINTAINERS: update Geliang's email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-7-f75cc5b97e5a@kernel.org>
References: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
In-Reply-To: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>, 
 Florian Westphal <fw@strlen.de>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tZVKtIFKLYUt/oUS595FbNi1gycPQG00LtyiN6EKU6k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxReiRCw+6cpvej3wyzo48ma+ikX1bsTWfnN8K
 mGQLRB5xOGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXogAKCRD2t4JPQmmg
 c4UJEADeoCILa8kvid/d8rgzep3cR6jKmDzEGODmFgosVbyMKYZVrdxDdyQqfw8CwbHtgpwhO8X
 9YmoWCOvs3f3/7Mf8cQYS4isCSuSt9MoyB2/MZjHX3JDuWOIqE7E4F4cNVQdskcT6ztSugCbMoE
 7iQK9iSFMJAwJAF6U7qd3COGYLJY8xzo1eYOXJYnnteDSLcifXuu775elASlE+aLI7Ppwk0srtb
 ADZuDQZh3v2yekBgm6PYi6raHNl0qdDwSaWCVebqnztwKien9kGD5MX9OxqCT4DilvVsiFNLfbA
 +zVLMKA3yKIw8OJ2XMZuJ7Ni+kjE5rpskdWNbOSASkl+QMaV2GAu0aewpprA6XX0JdBxrfFXGzI
 XyzQRN0PlTx0J9dU8KR2ebwJDHeLgf3lqVXKIyjS19K4kBsPVK1v2JMApy3ikyDuw68ntbD367+
 u8HAEIrDTiSraolcW8GRaImki2/LhP/PNgl2W9ttgucddtoYcjesrXYpW3akNMqp9ACtcFfy1N+
 Locb/FRi5jBFEqoWEvHxXi7VqDftm6r+JsxScZFFDpuW8pGr/esA28xh4YDh9Th5fHDW/Qwwirh
 6e99w8h3kG7VpeBBnaWUTbWaIJvqY9LO8oiOzUaxnGtO9m/3AlDLhYFLjxAIufEimViK1jvPrKp
 JLKpCrzKGpkkGoA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

Update my email-address in MAINTAINERS and .mailmap entries to my
kernel.org account.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .mailmap    | 9 +++++----
 MAINTAINERS | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 04998f7bda81..327e7eddd146 100644
--- a/.mailmap
+++ b/.mailmap
@@ -191,10 +191,11 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
-Geliang Tang <geliang.tang@linux.dev> <geliang.tang@suse.com>
-Geliang Tang <geliang.tang@linux.dev> <geliangtang@xiaomi.com>
-Geliang Tang <geliang.tang@linux.dev> <geliangtang@gmail.com>
-Geliang Tang <geliang.tang@linux.dev> <geliangtang@163.com>
+Geliang Tang <geliang@kernel.org> <geliang.tang@linux.dev>
+Geliang Tang <geliang@kernel.org> <geliang.tang@suse.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@xiaomi.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@gmail.com>
+Geliang Tang <geliang@kernel.org> <geliangtang@163.com>
 Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 42bdf99ed979..d7b5c622575a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15324,7 +15324,7 @@ K:	\bmdo_
 NETWORKING [MPTCP]
 M:	Matthieu Baerts <matttbe@kernel.org>
 M:	Mat Martineau <martineau@kernel.org>
-R:	Geliang Tang <geliang.tang@linux.dev>
+R:	Geliang Tang <geliang@kernel.org>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev
 S:	Maintained

-- 
2.43.0


