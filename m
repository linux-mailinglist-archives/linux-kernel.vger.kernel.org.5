Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9437884EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbjHYK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbjHYK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987CE2110
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E87C679B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1794C433C8;
        Fri, 25 Aug 2023 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692959320;
        bh=WR5rJnMPFIZbEiu4b92VXv4anq8fAF3KLyv5xA8v0MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lw9HMWnReyvbebZjrH+X9I3k21rtlkBbHd6UEGDrlEHZvQDizzeEYySgTxpa4CcEf
         SlHl/iGJw9lMPXeBNRSL/CKUPO3rKxYCwYghx9JbxpToYYdciemjH1k3GyyUARfYLV
         4Dr31J46FVIoi891flKwEG3sC36pPt8JV9dtEFlsgoUcOadPMKuk/AILxASCO7ipyq
         4nBP8VjTrUCt1h5KWYxOMfY/9RIfusu74+PaHgCzlfomG57cCExdNtYgRKun2fYm8I
         x0n6wT6qwxWdiEw3Cmk63PkyX1CZI/aUwPXaTEY62PryuK0rsEr91GMKfGV1cOAux/
         GwrXKrt1PeRzg==
Date:   Fri, 25 Aug 2023 11:28:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND,v3 2/3] ASoC: mediatek: common: revise SOF common code
Message-ID: <ZOiCVCJMaNX9Xhgy@finisterre.sirena.org.uk>
References: <20230825024935.10878-1-trevor.wu@mediatek.com>
 <20230825024935.10878-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qZGV3Md4Y3CzMmE6"
Content-Disposition: inline
In-Reply-To: <20230825024935.10878-3-trevor.wu@mediatek.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qZGV3Md4Y3CzMmE6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2023 at 10:49:34AM +0800, Trevor Wu wrote:
> Originally, normal dai link fixup callback is overwritten by sof fixup
> callback on mtk_sof_card_late_probe and it relies on the mapping defined
> on struct sof_conn_stream.

Angelo?

--qZGV3Md4Y3CzMmE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmToglMACgkQJNaLcl1U
h9Dv3Qf+POxM9sVWwvYGhP7SaK28bRrbWzMUGisxBE2aZby/aauTn/kZqgsiks2R
Etc8yDkOPbuDz/xyjvRda6ABgbQ7HYduuhcHxOmkfJMaAkRUtFG9kUJ0ILE2+lMV
CBP+y2Qtn1Zqfp4Fr6Iqq055uAWv70LtGNCeMeWuDBh9Insy2HVGQ04sN0voOKzl
x5rQNFFrriXLVejqXNaQiqON/h4XqKuSBX+4ev+rGORpy5fzSPamX/+ZnPqYtbeK
zs0dBIRZF4EcqHWvq5nhJr7VxUg9ROUeTnoXvMYWEtJMK1JsTtM0b8pYmz/3JFxr
bToxhRrTPnbUzLetGKrgYTRtpJEHaA==
=bFHg
-----END PGP SIGNATURE-----

--qZGV3Md4Y3CzMmE6--
