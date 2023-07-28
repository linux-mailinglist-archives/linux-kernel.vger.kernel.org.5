Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4D766E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjG1N3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjG1N2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E63C2A;
        Fri, 28 Jul 2023 06:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6995462155;
        Fri, 28 Jul 2023 13:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05421C433C7;
        Fri, 28 Jul 2023 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690550814;
        bh=lpIxrmKmbOC7WRk7UtNOjkyEwzHrgZsH0CggdVA8FGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5EVvaCzpJQ4I3pL/dqanw4An88CDoDbuoxNALg0XrSbi+gG8ZdD18x/u13pPRFvs
         szdS5EFpi7oxt3xFKvDYOxTm8D5z8Gp3V86McLswxN0c+UChvniaenoibuvyAxQ/vG
         u2p+TbOnwF9T87wQ3w6DqrgPk/5v0wqKbZ3Xq/oly9L/XSG4gkl6X1icdEcLra3Tyh
         spwuMgqoY3ckyUtxgqTSacvHP+XihYaz6/x74xu/H/8dIh3wp83EwmhzY/gwKZBtr1
         azeL+cbsqfGQCJGjSyw6Gd3UnyCXPinEl+Vl81NwPm0vQOxKqzmtUkMUmFsSC97Kz6
         /hgp/mm0jbUiQ==
Date:   Fri, 28 Jul 2023 14:26:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Message-ID: <557424df-a8bf-4b52-af4e-7f6dbe660cea@sirena.org.uk>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-7-maso.huang@mediatek.com>
 <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XT3kLeQv44OA4A+I"
Content-Disposition: inline
In-Reply-To: <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XT3kLeQv44OA4A+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 02:51:26PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 11:08, Maso Huang wrote:

> > +  - assigned-clocks
> > +  - assigned-clock-parents

> You should constrain your clocks per variants. I doubt that they are
> really so flexible/optional on each SoC... or maybe missing clocks are
> result of unimplemented parts in the driver? But then this should not
> really affect bindings. Bindings still should require such clocks. Your
> DTS can always provide a <0>, if needed.

Depending on what the clocks are some of them might genuinely be
optional, it's fairly common for audio devices to have multiple clock
inputs and be able to select between them depending on system
requirements or to have bidirectional clock pins which may be either a
provider or consumer depending on system configuration.  No idea how
that applies with this specific device.

--XT3kLeQv44OA4A+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDwhYACgkQJNaLcl1U
h9AF5gf+NIN7ZO19dqJ/AAyoSKsZgUmZxvpWcqc20xa2BWORhhpXVszso2nROeQY
jsefIMUnAc0ZTUc+dTecZiFZBTZKRAjeIa2yoESwzssTXpGzFjJl8Nik7G+RCTcM
Cz283cPsg9KbhhSqcBwKrmcFfnNpGpjgk9r6/gCtt01raGtRdzRlWJAWJH3eqe9T
OuE/jOaguHuHjkw49hcGqUdlSj5BqdPjO/6wMm9cuS1jQ0VPwAraH97T2JXH9sGK
ufNZ9h8Bh2XQGOFgK+ADXUP2DdGNuIP/uxz1kBRSL+1+VI8DjFD09wRJB1/92bye
JQFqsIVQhdj19h5m2Y/IKt/qut1ppQ==
=zUSr
-----END PGP SIGNATURE-----

--XT3kLeQv44OA4A+I--
