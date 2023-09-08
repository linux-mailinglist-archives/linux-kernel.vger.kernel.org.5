Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3C7992C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbjIHXU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbjIHXU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACE133;
        Fri,  8 Sep 2023 16:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E1AC433C9;
        Fri,  8 Sep 2023 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694215222;
        bh=1nkvFtVYE6mG4enJsXLmgOQmQm0V3mHWO63X25P49hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HahHIcLepJzUpvY5xRx/aiPK5t6LgCPxVAt4TxYErUyBroD+LxGK2g3EU7f1kWGN8
         19Sg2/QgVL6TnFgLUIJm6WlKRugP/jBu/zwqUtP8jh1i95elk6b/3LT+s6rV4cGbSw
         UoE9KiYMNJsAr5LVtW4PTJdsTFPj6bBoN3hD/wHbuFdvCY72JP+7KR0z96Ztv+6rKp
         dtOvS8AHWsMP0cEexjw58VOoWQ3Z9uOIAucGGrw5/h7ePdi109Ty4BkWVcu/V6saSy
         kOepkWy00kf+VBvFEyuPCiyYYSsxO7s0Wt1pno+OYfXnNCTGuGGhrlpVNh7GYzEdwM
         sIqyaDI/uyrYg==
Date:   Sat, 9 Sep 2023 00:20:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        lucas.tanure@collabora.com, pierre-louis.bossart@linux.intel.com,
        rander.wang@intel.com, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 6.4 04/31] ASoC: amd: vangogh: Use
 dmi_first_match() for DMI quirk handling
Message-ID: <8d75077a-799a-4bf1-b259-a931c00fbc54@sirena.org.uk>
References: <20230908193201.3462957-1-sashal@kernel.org>
 <20230908193201.3462957-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HJU+WQ/4Y17Xqo4d"
Content-Disposition: inline
In-Reply-To: <20230908193201.3462957-4-sashal@kernel.org>
X-Cookie: My EARS are GONE!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HJU+WQ/4Y17Xqo4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 03:31:33PM -0400, Sasha Levin wrote:
> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>=20
> [ Upstream commit 3dd26e27ccb4f18b4d25c0a49e1888eca9c6a724 ]
>=20
> In preparation for supporting ACPI probing, move DMI quirk handling
> logic at the probe's top, to be able to return as quickly as possible in
> case there is no DMI matching.

As the changelog clearly says this is preparatory work for a new feature
and therefore not stable material.

--HJU+WQ/4Y17Xqo4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT7rC8ACgkQJNaLcl1U
h9ANKAf/Uh5mXAR2JkTFtWmICqsgIMotI0tYYL1EQJOl40jGGQD3LyX7eU5+CWlD
zUlN60tqi37UvIWJyh1a7n9+L6kdNTPlmBEDO2d+/z+JnQ4hl5s73WQyvXOrzkpQ
ixmuWHh2exU257IBynFuHNbjys23co5MVDw7qfKl9Sd/XZtjRUURLsqNLrUPGNM7
DIyXAQODuKM06mjHzuQj3oemcBaYuiEZUmIzK8n3MbtEw0fVqGPfhenP5WNeI2Cf
5NvlAncOQNmXZVMd8Y+5lowDh8+D+/qYWAhtKTcvONki04i94sGjeKFf/hIeRJ0O
mOs5udsejjhFwCerwfhXCtxMGyIVJg==
=9KWO
-----END PGP SIGNATURE-----

--HJU+WQ/4Y17Xqo4d--
