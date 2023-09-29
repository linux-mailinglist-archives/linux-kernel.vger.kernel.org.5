Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B57B36CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjI2P0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjI2P0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:26:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520071AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C236C433C7;
        Fri, 29 Sep 2023 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001175;
        bh=a6761QvQRE1xtpY5lhrhWHOaasJib8GidjbbwOgM82M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tzi+o/tBEBP4461DI/dGBBkIzRBjoNMab6UDQNhWdyUrn37T0w6SZiYuKK5QRK4Sc
         lTlOI26Po8hWGPPQxw18QHTQswbCk7kXddrF94EfNLD1NNylksLo/bLoj10wC33cMf
         kk6QQlNv6NLXKslFIGujVWA4/fJQzZyQ5tYMse5TS+j3DNqmYZpnCd0nH+KjUyBV+b
         aAty6N5WvlaT0PGEaJnvbytVWy+kLFLkQdevtVcklzdlLEWeM4DRrhKmUoVU4JI+Fc
         9ud2oOFaDyDSqM3PeZuXZlaMOHGSMhJnC7PMuYYWGmuA9Xz4KjvgBW0L1NSPBoq33P
         hOyX6wNMhIowA==
Date:   Fri, 29 Sep 2023 17:26:13 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v5 02/12] ASoC: SOF: core: Add probe_early and
 remove_late callbacks
Message-ID: <ZRbslaHeR+5JgdD+@finisterre.sirena.org.uk>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
 <20230929145123.233838-3-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/njO6HX7W3+mjKuA"
Content-Disposition: inline
In-Reply-To: <20230929145123.233838-3-maarten.lankhorst@linux.intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/njO6HX7W3+mjKuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 04:51:16PM +0200, Maarten Lankhorst wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The existing DSP probe may be handled in a workqueue to allow for
> extra time, typically for the i915 request_module and HDAudio codec
> handling.

Acked-by: Mark Brown <broonie@kernel.org>

--/njO6HX7W3+mjKuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUW7JQACgkQJNaLcl1U
h9AUtgf/YApaEB7FmIa5/bkJ+zW+uYABrL/XbKWdtakaKUYLoWxSsNfcfSOd1QoA
/eSO8Y4jTFYpbOpjex7SJ1l58gqPa7cqQNXZYxQq9d5wOCGn46s9X9CYSiuf0Bau
ke6hkU2LqvyRlGjX1E4Pf7GJdzxwndy7CsasIHjTcVtb6vaIETrANWwgojWJwVnO
v492ROgGIoDJdZA1Oj7m3nyy3/LLNJL1skj6wzbyt8IqTlq5npB1koIp7FI+Nllo
fvLkUsr7+Cp65etyvjIu23WN2dK9/W3yYqwyQVHwGxaV9mrGzG0blT5izuawATji
qLfg1rIdlZ5p99hZwNgpG/j7+/MOVA==
=3vPj
-----END PGP SIGNATURE-----

--/njO6HX7W3+mjKuA--
