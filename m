Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8F802E33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbjLDIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjLDIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:44:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880D1B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:44:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6551C433C7;
        Mon,  4 Dec 2023 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701679454;
        bh=xpgPzulNevCUlsiFp2dMGa9+E23juK/4xiRXU8jbrZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFePe9RdWDFr3EKCrhfUl0e058tQhYJziFpa8yaN3dgBfmjplJZ9qi0/Tc+rwjCLP
         rEMOyKPmOgH8KFEs2421n+fT4vOuF41M7oRIU8vr6XFrytPfdiLcZ3YKhgTePVfkvG
         m7vl5fPtC7j9bqtyHRTQjPJhegtSoLtfVpIucaZO9K6cwPvZD0VT6/b3P13SnH3pfs
         Hs6S4AHl1bumAZBkKWc4nelEpqMCgoqkdVxZGoMQBw90+d1KPfFGT1BpTzNUBwWEs2
         WgoRgUNI9F/fMMuzLJ7dzaS/PDFiPMwqCcpKxHOoRLjvpkD37lYNIoNGhB44JA1ku3
         nr8tAJJzWi+UA==
Date:   Mon, 4 Dec 2023 09:44:11 +0100
From:   mripard <mripard@kernel.org>
To:     =?utf-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
Cc:     airlied <airlied@redhat.com>, kraxel <kraxel@redhat.com>,
        "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
        tzimmermann <tzimmermann@suse.de>, airlied <airlied@gmail.com>,
        daniel <daniel@ffwll.ch>,
        virtualization <virtualization@lists.linux.dev>,
        spice-devel <spice-devel@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Friendly ping. I think this patch was =?utf-8?Q?forgotten=2E?=
 =?utf-8?B?Ly/lm57lpI06?= [PATCH] drm/qxl: remove unused declaration
Message-ID: <kk4xtz2zxe37ner7cl5qvlk6jhciu7hgvpltf7gddphepnxqwg@noe3lrmff3ax>
References: <1290mcwo8vf-129368jicj0@nsmail7.0.0--kylin--1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrjqp5qcdvleulqp"
Content-Disposition: inline
In-Reply-To: <1290mcwo8vf-129368jicj0@nsmail7.0.0--kylin--1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrjqp5qcdvleulqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks for the reminder

--mrjqp5qcdvleulqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW2RWwAKCRDj7w1vZxhR
xTKFAQClXxO9sDpuh6JQFW2Xg1PnWk1Pz9aynBWEXekfGLIqLgEAh0s5I+A5LU+X
+S+NsqIYz+28V3nfD/itBaG2c2ON8ws=
=wUoA
-----END PGP SIGNATURE-----

--mrjqp5qcdvleulqp--
