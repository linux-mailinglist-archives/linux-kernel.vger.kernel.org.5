Return-Path: <linux-kernel+bounces-69452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85185892E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC001F2706A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB61487F4;
	Fri, 16 Feb 2024 22:50:44 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D1482F4;
	Fri, 16 Feb 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123844; cv=none; b=EApYbYKLVWZrjnLTHLMVIKZy6k+sbbBHRvMrhhn7qr9TD3y8P1vSOyaxAPwPGMtDpzKxJgVlbRhNlSNB5BmjJjlrzeLGb1ouS3RM+TVKbxve93mCVp7eWiqCtBQhIhAFyF446ozva1y4IVJV6FPu+YrEtGWpQLCcdXra3nEvBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123844; c=relaxed/simple;
	bh=omTmCeDmSiprRI0GmaFZmMPH5zykM96/fkUAYDI8C0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOHP6YOerezbFuOK3Ohq2gBed1P0AAvklN9r/+ekJ+tX3I0CraS7YYL8QFtiv3/41v6Mg0yNnDk+SQ0gK0oM4qdzT1tQL66pC/OfrCyTt2yggL6ms4G+fNbw9LAs6e4B4JGhdsR/Wpk26N+pPtdlEOa8vV6RMXu1f4yYBn65kXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rb727-0005Zt-9A; Fri, 16 Feb 2024 23:50:15 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>,
	neil.armstrong@linaro.org
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
	quic_jesszhan@quicinc.com,
	dri-devel@lists.freedesktop.org,
	sam@ravnborg.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	quentin.schulz@theobroma-systems.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: add prefix for admatec GmbH
Date: Fri, 16 Feb 2024 23:50:13 +0100
Message-Id: <170812374212.3826997.17392581213989384706.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215090442.3513760-1-heiko@sntech.de>
References: <20240215090442.3513760-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 10:04:41 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> admatec GmbH is a german supplier for industrial displays.
> 
> 

Applied, thanks!

Adding the link to the manufacturer Conor suggested.

[1/2] dt-bindings: vendor-prefixes: add prefix for admatec GmbH
      commit: 9de552935b6ceaa113d205232fde70e5345bdf29
[2/2] dt-bindings: display: panel-lvds: Add compatible for admatec 9904370 panel
      commit: c530379a6876eb4c9c4a83f1b65d8cd9d66ee229

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

