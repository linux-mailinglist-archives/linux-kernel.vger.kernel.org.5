Return-Path: <linux-kernel+bounces-2864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CCF816351
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CEB28286C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE14A9A1;
	Sun, 17 Dec 2023 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA0cEL0P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C94B121;
	Sun, 17 Dec 2023 23:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9A1C433C7;
	Sun, 17 Dec 2023 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702855453;
	bh=pNEGevUBy2MW6+ThrcovCIC+ZAo8Hmxjtv4TDvgyzzo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QA0cEL0PTmccrSOSdmbURrOXWPFmkUDOg9a8Gnn9MOa1eH01ru1FUJJmHrnshBHwz
	 iM8O9ZBl7t0iaXFboUNcw6/5qQy/1+tet5IzBIPnRKuybnnnqTxuBFlveoeCYbx/VJ
	 0ir2sgJspXM++xE4FXRjTL+oXFfQk6olHnCT6ARHeiCpGzb1gzdpQtJ7WiN2L0JSTV
	 bXLDHnGmTgthreeapYW9lJ+h8N0cDriwdbsoOGIcmYT+2KkytTLgGhmPdi8BN4rQnB
	 SOvTjS/LSoSVeslW/r/fZhWxkNSapp4plQ/bOYl5QKIogSK6pJxr+7aqlu0ZJ7Hp76
	 zVUI84l9N3/Yw==
Message-ID: <9d1b2eb4868f82015b88176a3666cbad.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZVED01t3+coBd44x@standask-GA-A55M-S2HP>
References: <ZVED01t3+coBd44x@standask-GA-A55M-S2HP>
Subject: Re: [PATCH v3] dt-bindings: clock: brcm,kona-ccu: convert to YAML
From: Stephen Boyd <sboyd@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Scott Branden <sbranden@broadcom.com>, Stanislav Jakubek <stano.jakubek@gmail.com>
Date: Sun, 17 Dec 2023 15:24:10 -0800
User-Agent: alot/0.10

Quoting Stanislav Jakubek (2023-11-12 08:56:51)
> Convert Broadcom Kona family clock controller unit (CCU) bindings
> to DT schema.
>=20
> Changes during conversion:
>   - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
>     such a clock doesn't exist
>   - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
>     such a clock doesn't exist
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next

