Return-Path: <linux-kernel+bounces-167599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BE8BABC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC2B1C2182A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED9153804;
	Fri,  3 May 2024 11:38:55 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EA152E0B;
	Fri,  3 May 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736335; cv=none; b=K+9BTYAtaR5QGM126qkPQlHCAgI7M5fkTNFrOHM9DK7Nize8TfSuly6QrEn8rxFWTpk6dNi3qI43nhi95G8pasboPcdqjxoHEopCS1iZHGw0bDy4QhgGIj+Sa5dnAcWkbxEsfBZxnx+JRWtgD73p64FeJ9S5++trFqL1SFXTp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736335; c=relaxed/simple;
	bh=X47e0mmrRhPchWaEeKQweS7dhh2LuGbRfLXjiIYlUIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Phqx9yK3x1Gew+3Dp9dDHPr6wyy61P/bXrMRNXFE8gMeiAzxF1Jy5znfVFteC1oHgFZTXZ2C7qINYaqhM9EDUKDwiS0bq8XWvzQxlL2mqXmTfiAL9h+4PyjlNvWW+OA2XznS0RsuXsAO3cvMtZ5qmgdgNowEtBV3AHwWIfEoSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s2rFR-0000Tc-Tg; Fri, 03 May 2024 13:38:42 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	efectn@6tel.net
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzysztof.kozlowski+dt@linaro.org,
	sebastian.reichel@collabora.com,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable GPU on khadas-edge2
Date: Fri,  3 May 2024 13:38:23 +0200
Message-Id: <171473602994.3469033.12209087270295782183.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501142241.98554-1-efectn@6tel.net>
References: <20240501142241.98554-1-efectn@6tel.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 1 May 2024 17:22:41 +0300, efectn@6tel.net wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 
> Enable the Mali GPU node on Khadas Edge 2.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: enable GPU on khadas-edge2
      commit: 4aae6cdd61aa0daa2f01d1660be8f22b88b61929

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

