Return-Path: <linux-kernel+bounces-8226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1681B3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C525D1C23DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E816EB58;
	Thu, 21 Dec 2023 10:41:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC798745C8;
	Thu, 21 Dec 2023 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5Z3GcXz4xGT;
	Thu, 21 Dec 2023 21:40:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, David Heidelberg <david@ixit.cz>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231212184515.82886-2-david@ixit.cz>
References: <20231212184515.82886-2-david@ixit.cz>
Subject: Re: [RESEND PATCH] powerpc/fsl: fix the schema check errors for fsl,tmu-calibration
Message-Id: <170315510024.2192823.6759883781736803779.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 19:44:58 +0100, David Heidelberg wrote:
> fsl,tmu-calibration is in u32-matrix. Use matching property syntax.
> No functional changes. Fixes warnings as:
> ...
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fsl: fix the schema check errors for fsl,tmu-calibration
      https://git.kernel.org/powerpc/c/9ec1d7486e2520b4898d7f8e1ec3acc7c13c8dc8

cheers

