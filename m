Return-Path: <linux-kernel+bounces-3197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA83816905
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289F51C2240C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D310A10;
	Mon, 18 Dec 2023 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+XVsb3l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5517111BA;
	Mon, 18 Dec 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C157FC433C8;
	Mon, 18 Dec 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702890025;
	bh=kOt2oa8IgWi2j+caHzVUn+hakr7YNKwwW253Dd8sbko=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=J+XVsb3l0Wp5QZsCKouEhWlMC51XiP4uxnRdN+nMGVBFWebpoaDguAhw1vUZPu0ze
	 fZFx4nul9hGzA/4Izbij9TVWYiiSs3LwH/XdcurNv2/9r10hWm29RCy7phw5HUBLLQ
	 5sUMPG2HLUvJ0uxfzutlZU/XAneq10z7Mob7j1a9kbVDxAVPyYJeq+uwIwQNl2I7CU
	 59x5WKcTvj80UR76gDCsZMoqkcefUn5NqCZms07+2OJjYxNeDJSzXqXCGPm8hXB1ba
	 1yU+45TJVjUk50I6AcUv3MP/XhS0n+u44gs80hSyGr3ss6BddLd+ne6+fcdVs9XM3n
	 /CySGXdH3nZOQ==
Message-ID: <df0576baf95d8130b5034c4ef80e8d18@kernel.org>
Date: Mon, 18 Dec 2023 09:00:22 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Alex Bee" <knaerzche@gmail.com>
Subject: Re: [PATCH v2 16/27] drm/rockchip: inno_hdmi: Drop irq struct
 member
In-Reply-To: <20231216162639.125215-17-knaerzche@gmail.com>
References: <20231216162639.125215-17-knaerzche@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Andy
 Yan" <andyshrk@163.com>, "Conor Dooley" <conor+dt@kernel.org>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Sandy Huang" <hjc@rock-chips.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, 16 Dec 2023 17:26:27 +0100, Alex Bee wrote:
> The struct member irq isn't used anywhere. Drop it.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

