Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E67D9E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjJ0Q4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0Q4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:56:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B6E1;
        Fri, 27 Oct 2023 09:56:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9C2C433C8;
        Fri, 27 Oct 2023 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698425766;
        bh=6KR9VoHdwdtNQoBQVNC4uX/fSERgy6G3imQoICIl/q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIU0IUME//oCE20/frms+NxDBQ3K3obqNzvrizh2nHZUQPIpSbTRfEcefCAeV03ne
         KkMpgSI2JEEwKjfCR23eYaUbPkJeMuH6pLrI83YZR2lLpGpStPNBQd40/GYsyOJ5xp
         XgtIpqPDG192sVgI03WnML8niS6QfI27t4uUG8EnufXB+ByPWpRNrFGL9A3cvo7Ush
         8yjAYdV83p/pJQNePHC7vGU9vz3jAb/YCBzcsJcbNTHLbODIBr2QHOvUUNGm63+xaQ
         fbL1eeqXt2uME+wUJ7ZK/CYpCqa3gK/guMXg9NpjCJ1jMeOWSLRUkqKlEIDwtz9kTH
         54Mo4/l+kiBwQ==
Date:   Fri, 27 Oct 2023 17:53:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Harald Mommer <Harald.Mommer@opensynergy.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harald.Mommer@gmail.com, quic_ztu@quicinc.com,
        Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH] Virtio SPI Linux driver.
Message-ID: <ZTvrEFjL3nCRRQnY@finisterre.sirena.org.uk>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="drsnOhJQNNTzIVON"
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--drsnOhJQNNTzIVON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 06:10:13PM +0200, Harald Mommer wrote:

> This is a virtio SPI Linux driver which is intended to be compliant with
> the proposed virtio SPI draft specification V4.

Do you have any pointers to the drafts?

--drsnOhJQNNTzIVON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU76w8ACgkQJNaLcl1U
h9CwQQf+K8JVo/lToCrGUl0aOjwmASAtJDpDVy1TPlvgxXsUpFoz1HaYn4Mb+ksX
q6MU+D5JQ2rdi7hf1ISWoJPr2KoxW90XdyN3/9vDzmANHeEx1/GS8uChm3lh8xFZ
13FTqzMlo6R/W9xo3i3PSLzNH9F+Wye1pRao01WyLYYNsUMYTWF5iuu5Wa1YzCxS
9lxidaHdhN8D/qqumA1kRfKOp9TaRzRpCynSuXGkBOFYHWi6S/lisTRcbuFp7Dg6
PCNZTN8cS7I6GKhdmuNfTixDPVDg3QiC/bGjFzMGF8crdjxp4bSrjP4wo5PAuFvp
bEwTlEOnG0FE0f1KbdWVnaSOV5Hxxg==
=v8Ya
-----END PGP SIGNATURE-----

--drsnOhJQNNTzIVON--
