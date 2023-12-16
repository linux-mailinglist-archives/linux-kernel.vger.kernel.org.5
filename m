Return-Path: <linux-kernel+bounces-1929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2120815602
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763751F255EF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2E1363;
	Sat, 16 Dec 2023 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAE6fA4L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C91100;
	Sat, 16 Dec 2023 01:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB62C433C8;
	Sat, 16 Dec 2023 01:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702690602;
	bh=DbYrcKAoTNLUNGyDpA/R7g3cN+HpPHrCpoTLepoB8dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAE6fA4LwYFWMCl/iZ8s1ebDza9YXEQqd0eVPTEL1ediYrLSdfILPFXxrBVg1iDiq
	 oynyR85Eal9jEJKWfYyP0vnltGuDGBZ+4DtpUbaj2806WzvWisWDrS0dQ4QEhTlxPd
	 w60/18/V5bS7iO5C+y4w5jUfvXsgmgjcktQempapCIfI6O/QVlkg05QSSmQrUqsKf6
	 N3l/2U7IxjxPBY6TNRGfnrLzVrITWOEquTHhKkBjg7p5Sah9JvuoaLjoTpzcFI411/
	 HwCWNGB1nzysUnmk6Z4AkdvfOtRnxOR4AauuA2E4TSEl5mEt6rsvpAETQaCMSmJS3q
	 WU//q0+TXyxUg==
Date: Sat, 16 Dec 2023 09:36:36 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
	Amarula patchwork <linux-amarula@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/3] arm64: dts: imx8mn-bsh-smm-s2/pro: add display
 setup
Message-ID: <20231216013636.GI270430@dragon>
References: <20231214082457.18737-1-dario.binacchi@amarulasolutions.com>
 <20231214082457.18737-4-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214082457.18737-4-dario.binacchi@amarulasolutions.com>

On Thu, Dec 14, 2023 at 09:24:06AM +0100, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add the display and nodes required for its operation.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied, thanks!

