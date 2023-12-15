Return-Path: <linux-kernel+bounces-1611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B18150DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A45B1C240F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DFF47F77;
	Fri, 15 Dec 2023 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adIVa2ji"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1146445;
	Fri, 15 Dec 2023 20:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32ADC433C8;
	Fri, 15 Dec 2023 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702670609;
	bh=c3AVRVEy1u8nl7MxlBgA51P8YXTjWZByYGvp3E/El8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adIVa2jiA+F6CC5GfdAFYQ3mtjewwauLcGfiV/kJtmd4m46kgSYZZcuhDlbJ+S/5b
	 dfdxOtfgP06fqwKgkSfccJEvT90+cEYefpmUcGWRoomXqWW2ORiWHDY+Z0Dj+khufP
	 KKTRIprUkD1IT7hrKlaWwXhpSZXiWKyNrHQAFgD7obEVviiCrPiBUhOMENAU/xUt5z
	 uDljQMMA9lgDZh0I31Fete5pc7alKmX1YShIks8WpowYlWlwkyMpShkwxxHgkh3buf
	 s12dO00McnklcoJPtlNHbBcrN9HAbER4sHFripKsLk15bGbBQON659sreCVk38pGkP
	 rBMFR141eMQ5A==
Received: (nullmailer pid 304252 invoked by uid 1000);
	Fri, 15 Dec 2023 20:03:25 -0000
Date: Fri, 15 Dec 2023 14:03:25 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, tiffany.lin@mediatek.com, matthias.bgg@gmail.com
Subject: Re: [PATCH v2 5/7] dt-bindings: media: mtk-vcodec-encoder: add
 compatible for mt8186
Message-ID: <170267060230.304140.8670744494776319731.robh@kernel.org>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
 <20231215104551.233679-5-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215104551.233679-5-eugen.hristev@collabora.com>


On Fri, 15 Dec 2023 12:45:49 +0200, Eugen Hristev wrote:
> Add compatible for the mt8186 encoder which currently works in the same
> way as mt8183.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v2:
> - new patch.
>  .../media/mediatek,vcodec-encoder.yaml        | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


