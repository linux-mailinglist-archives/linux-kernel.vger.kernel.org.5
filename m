Return-Path: <linux-kernel+bounces-10848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C7181DD54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBC71F21A88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9262D;
	Mon, 25 Dec 2023 00:21:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A260361
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193c.versanet.de ([94.134.25.60] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rHYiR-0007kx-Rn; Mon, 25 Dec 2023 01:21:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Abaci Robot <abaci@linux.alibaba.com>,
	maarten.lankhorst@linux.intel.com,
	daniel@ffwll.ch,
	linux-arm-kernel@lists.infradead.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	andy.yan@rock-chips.com,
	mripard@kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop2: clean up some inconsistent indenting
Date: Mon, 25 Dec 2023 01:21:05 +0100
Message-Id: <170346364425.2455794.13619549678241145924.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219062635.100718-1-jiapeng.chong@linux.alibaba.com>
References: <20231219062635.100718-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 14:26:35 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:1708 rk3588_calc_cru_cfg() warn: inconsistent indenting.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: vop2: clean up some inconsistent indenting
      commit: f40e61eb538d35661d6dda1de92867954d776c4a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

