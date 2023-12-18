Return-Path: <linux-kernel+bounces-3198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30716816907
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088511F22A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67351119F;
	Mon, 18 Dec 2023 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWMNYcNb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52611C9B;
	Mon, 18 Dec 2023 09:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5016EC433C9;
	Mon, 18 Dec 2023 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702890034;
	bh=pN5LILtZ6jkI/p6vbAQqvhmG+HEe59duVyzW2V849YA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=GWMNYcNboJdrtLSM3AHLe8A3hgBACpV18b2Ta+ziuZ7Bo6uSy50Lt3t6Jeehf3dJz
	 8sOCZd3Btw910W7g7dlSGxhGr+32PGDvqTF0G+TWO7p3sriScUofoxmldAmYzaZDDl
	 fStQuaYAy7kV9stgwTHyiCMuZ3L43vD5bf81gM++tWab2MBk2TDNqH5NzIKmkB4aE8
	 LwK6bvNaPPt6jJ/a4UaP0GgKXJuq1fC+l/L6XQGh6Pg/LazW2SxrWpc7YoggqZkp5D
	 QmP1CtM5qin6pQBQLSWdFYV63lI6W0/8vAx/rgFTsauwBpi3Xz42+00U8PbDwxUkqp
	 mZzscOVoDpr9g==
Message-ID: <3cc54ae7f4c9970090d60fcbeab144c6@kernel.org>
Date: Mon, 18 Dec 2023 09:00:32 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Alex Bee" <knaerzche@gmail.com>
Subject: Re: [PATCH v2 17/27] drm/rockchip: inno_hdmi: Remove useless
 include
In-Reply-To: <20231216162639.125215-18-knaerzche@gmail.com>
References: <20231216162639.125215-18-knaerzche@gmail.com>
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

On Sat, 16 Dec 2023 17:26:28 +0100, Alex Bee wrote:
> The inclusion syscon.h isn't used anywhere. Remove it.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

