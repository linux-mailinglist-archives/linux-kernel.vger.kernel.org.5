Return-Path: <linux-kernel+bounces-756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD8814597
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF4285345
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9D25115;
	Fri, 15 Dec 2023 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGrUXIxJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16140250E4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F301EC433C8;
	Fri, 15 Dec 2023 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702636310;
	bh=vFbU2tFE37clXv2Xl5gB2YnceDfRmJ14hCYQib0idGw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=IGrUXIxJovTU0LyzSnY5KAkgmcpMBYQxuXeISlBsJDNYrp/zEdCE8y0PAQGnzAh2B
	 En0ApJAbZdjS35gQZoKuH7UjBW+C9V8hcUyhYvOZBQypuTrN7cUVDqjjKWs8gy5obs
	 KIDNzTxVAe0Y3640AUwN9bPr6cDVHWhQg1eQ9iRp1Jw2uiNnJ0aS+0NPL+TOk2xKlX
	 SqinmlYo1FLc2ZW8YWIf5m9VBtUlKDSZADH4n5VDYmQ8v9L/1s48PRagAOKy3T1Nbh
	 PGRfz/o9QDv0lPInXzk6qhy1JqXpI3Op3ddgnADRRe3ePutHDzuwt3dz1CE4Ua6hNf
	 Liogtyiqbqbzg==
Message-ID: <bfbffc035ccc1da6c224aebea128764e@kernel.org>
Date: Fri, 15 Dec 2023 10:31:47 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?TWljaGHFgiBXaW5pYXJza2k=?= <michal.winiarski@intel.com>
Subject: Re: [PATCH v3 1/3] drm/managed: Add drmm_release_action
In-Reply-To: <20231211220939.215024-2-michal.winiarski@intel.com>
References: <20231211220939.215024-2-michal.winiarski@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Javier
 Martinez Canillas" <javierm@redhat.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Michal
 Wajdeczko" <michal.wajdeczko@intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 11 Dec 2023 23:09:37 +0100, Micha=C5=82 Winiarski wrote:
> Similar to devres equivalent, it allows to call the "release" action
> directly and remove the resource from the managed resources list.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

