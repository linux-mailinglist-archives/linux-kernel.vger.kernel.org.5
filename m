Return-Path: <linux-kernel+bounces-5212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7346818808
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC6528C3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF221BDCE;
	Tue, 19 Dec 2023 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpTVy1/D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB31BDC3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23465C433C8;
	Tue, 19 Dec 2023 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702990401;
	bh=3NmhXJQ7QHQFh1L8RP2t/8EnsXilOSZx6z+ReJD3+rI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=hpTVy1/D131MtaaFE+GY1w04ZsqoqjHu8jgip+p4cL7c8+/o7kHbLNs7b7zlyIpdc
	 kigUFKqHBqXHqCYF7MOUCifznyNrUepmsXA34Ba2j/RhXw1dRFs99x/Jr+IliMj099
	 qClhCBEeXhQRHFTTUjE/gkN1fkSUukhMyMRcPyQlmVPE9uHvUUzfTQR7I39eIiEDTk
	 Yy8MxYt32McjvJDMq7eafgE8BYjUsNER95xcoH6KRi5NyIR3vA+O6GKi7MEcLxkrdd
	 trMBdQROYJ9zn0rYfTNSktdSaD+5jHA24KMYvusMkRC9+XEbN/SYQMFZYYOaeG/jLg
	 FptQR80wxdWQQ==
Message-ID: <473e996c20451aa5bb700d30fdf0f16b@kernel.org>
Date: Tue, 19 Dec 2023 12:53:18 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Johan Jonker" <jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/rockchip: rk3066_hdmi: remove unused drm
 device pointer
In-Reply-To: <745f84db-dc9b-81b2-6171-4d8d86a96966@gmail.com>
References: <745f84db-dc9b-81b2-6171-4d8d86a96966@gmail.com>
Cc: airlied@gmail.com, andy.yan@rock-chips.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 18 Dec 2023 16:48:40 +0100, Johan Jonker wrote:
> The drm_dev field in the rk3066_hdmi struct stores a pointer to the DRM
> device but is never used anywhere in the driver. Let's remove it.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

