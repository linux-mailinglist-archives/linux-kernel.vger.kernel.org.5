Return-Path: <linux-kernel+bounces-21042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69C8288ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AD6287E65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29039FE2;
	Tue,  9 Jan 2024 15:23:44 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC939FD1;
	Tue,  9 Jan 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaa.versanet.de ([83.135.90.170] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rNDx2-0003rK-TW; Tue, 09 Jan 2024 16:23:36 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject:
 Re: [PATCH 2/2] arm64: dts: rockchip: remove duplicate SPI aliases for
 helios64
Date: Tue, 09 Jan 2024 16:23:35 +0100
Message-ID: <2258938.QZUTf85G27@diego>
In-Reply-To: <103b45c8-3e16-480d-9f39-c677da747090@linaro.org>
References:
 <20240109-rk3399-spi-aliases-v1-0-2009e44e734a@theobroma-systems.com>
 <20240109-rk3399-spi-aliases-v1-2-2009e44e734a@theobroma-systems.com>
 <103b45c8-3e16-480d-9f39-c677da747090@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 9. Januar 2024, 16:16:15 CET schrieb Krzysztof Kozlowski:
> On 09/01/2024 14:35, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > 
> > An earlier commit defined an alias for all SPI controllers found on the
> > RK3399, so there's no need to duplicate the aliases in helios64's device
> > tree.
> 
> That's not what we want. Boards should define aliases for what is
> available, according to the board labeling.

and the board labeling for spi2 has always been spi2-miso, spi2-miso etc.
In the last 10 years of doing Rockchip stuff, I haven't seen any schematic
doing it differently.



