Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F847B8D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjJDTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJDTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:40:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4DAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:40:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A5BC433C7;
        Wed,  4 Oct 2023 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696448404;
        bh=FlsaevMEj2RSWwYmDVDwqSBRXP3iR8ph2Wyz+A1kh6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOsLsmCHyEqNfe5KySvFctctkD4pd0SklEWoLKwtS2TGXNYHWnM24vd8N0uwuMBJv
         6pro430mVYoVMCCb9wmh/DXcdItJSy8tBlLSYBqCMcigkWVQE5pXeXEn0kVaiOUz2l
         BQ3/+WIU7kb2HlVocjvOZGD+R5oLH7YdfUWASoOXqAeNN5cSU0UxFlJrNRvAbit4wk
         /i8jiNusXW7xLKxfjXUE6oMHRegvv39Z3b1OXXvpPpsmKnCHp6JdaNoOcaBc7OHZil
         Q7jj4X2gc4dwiBiEvnW0jc2y9xoZGctBVIE5VI3EzALZjPsn4kV1IKTgNulNr2vWi3
         BBPqrKXeivBYQ==
Date:   Wed, 4 Oct 2023 20:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
Message-ID: <f258a7e6-0728-4f55-a71a-6e99113ce7e5@sirena.org.uk>
References: <20231004193441.work.109-kees@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8QQHSDF6ypZtF4tt"
Content-Disposition: inline
In-Reply-To: <20231004193441.work.109-kees@kernel.org>
X-Cookie: This space intentionally left blank.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8QQHSDF6ypZtF4tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 12:34:45PM -0700, Kees Cook wrote:

> +++ b/MAINTAINERS
> @@ -20116,6 +20116,8 @@ F:	Documentation/devicetree/bindings/sound/
>  F:	Documentation/sound/soc/
>  F:	include/dt-bindings/sound/
>  F:	include/sound/soc*
> +F:	include/sound/sof/
> +F:	include/uapi/sound/asoc.h
>  F:	sound/soc/

The SOF header is also missing from the entry for SOF.

--8QQHSDF6ypZtF4tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUdv48ACgkQJNaLcl1U
h9DDygf+JdiGJ8HYN9ucxA5Qvg+1jQsKP68oVMfoAYPDsXQ175C2gXEwiwypNkM2
Qj0l77i+ILIV54dZc9PBy32hmHgTtFcgoP78BGGQNVY+BQe+8rN3IWfsegG157i6
xiUSqqlGTs3Syxp2v7KTNdf3QJb43PL2Ofdxfy1JvhStZxX4xqSnYkkdLIJoClsr
edJVuq1n1S7a09uvZc1SqvQo4Z5sT2lfLNk5/DIPXdPkVUgr4cfARkPNNWYss3o1
z8f/M3naQ1u0Sc1Q+H/qiCnbHa5vVbrnjOV6ptbTeBx9Iuf1W6XPA7IraruLE9Ev
a69/R8wKeotb4Z/eg7Q5S+gAfTkf8Q==
=f8m5
-----END PGP SIGNATURE-----

--8QQHSDF6ypZtF4tt--
