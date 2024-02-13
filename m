Return-Path: <linux-kernel+bounces-64145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47B853AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA84B23244
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236E57883;
	Tue, 13 Feb 2024 19:16:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC05FF00;
	Tue, 13 Feb 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851788; cv=none; b=A+mIVHTDeolxqsaRKSK/RBcLok5ysFFqPpFVFXbpIxAmcI1zH6ydUTOzFbtyk/+l9V9PNvyNr/LP6jAWkQ9CNKKNEhTMYEuqlFxY11HSdlzq4FW90zvnP22QSEo+9y8fkN47LNtUob2ifNGviF5x/d70Z65poyqgS4I78IiFL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851788; c=relaxed/simple;
	bh=RzzSAlo8GEEFXWgAxEQxrUc9FUhK732AFy2kwIsdMbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9TFEpxT6X4si9dTb9Q3FqXENou79duhEle98GFeSwm8y64lMk7N4fRsAesZTdUdxBDYUjCcOklPRlOcThnnlAbJhyJPp8s+GCBPcXbSz3e6E4CxCBBdhgLxFrccKjy9F3evA+84p4CNDsY+DHrh0YP7vs4VQTkG5seC9yHoIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyGW-0008FY-6B; Tue, 13 Feb 2024 20:16:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rk3588: minor whitespace cleanup
Date: Tue, 13 Feb 2024 20:16:19 +0100
Message-Id: <170785172858.3347621.3639452641350737104.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208105129.128561-1-krzysztof.kozlowski@linaro.org>
References: <20240208105129.128561-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 11:51:29 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rk3588: minor whitespace cleanup
      commit: 00890f5d15f50bd386bf222ddee355cec6c6d53a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

