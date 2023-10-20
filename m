Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6DD7D0C02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376739AbjJTJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376797AbjJTJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:36:11 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A831713;
        Fri, 20 Oct 2023 02:36:02 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qtlv2-0001rL-2F;
        Fri, 20 Oct 2023 11:35:47 +0200
Date:   Fri, 20 Oct 2023 11:35:14 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     Larry.Finger@lwfinger.net, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] b43legacy: Removed unneeded variable in debugfs
Message-ID: <20231020113514.122bfb6e@barney>
In-Reply-To: <20231020092735.2565-1-bragathemanick0908@gmail.com>
References: <20231020092735.2565-1-bragathemanick0908@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kfDnOujsaQJS.7yl4+DvrH0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kfDnOujsaQJS.7yl4+DvrH0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Oct 2023 14:57:35 +0530
Bragatheswaran Manickavel <bragathemanick0908@gmail.com> wrote:

> Removed unneeded variable. Issue identified using Coccinelle semantic.
> No functional impact

This patch is completely wrong. It would not even compile.
Please compile your patches before submitting them!

And it is the second time we see this nonsense.
The code is correct as-is. There is no unused variable.

NACK.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/kfDnOujsaQJS.7yl4+DvrH0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmUySdIACgkQ9TK+HZCN
iw7mtxAAiVUycpeZTGhcQXIsXI5dmrqAsTA2Nsxr01vvreRpLZDZUFLOg7ou4rXz
JD5nD+4ZdIbQnlSyF4CVgpZbstsYSa0FGeC4yHnASIAX0Ou6x3bqhX28K+Gdb/RH
isjualTrLUR94jQJqjnFrTKjVD2ezTjG5i0NJSwP3roTohMXUfUApyJE7CV/URIA
SosRMc6aKnrfdd4pHidRLW1BVNKpY5NiK++rjwaPzxqy2riEzVyHKkZoQaJB2lHm
DBTDeRHj3D5ZUSlB0U/nlR0eyg3jixvtCONvXls2CDWOtLApSUh86Zm2BIE39HX7
3uxqnAsf+RmtuKxb4IhyqBAkHj6In8VQ4HL7yOflRdAZkKo3JkJBaoE9idYvP20Y
gWWi3NoIeLybwVRID/iAb/5SDGKHmjX4gBsxonOhH9066++kPWvdVHWDzdN5ibfQ
EEiX3r+l1rCuQfAlNrqgHR0UNgMxzCxAnWCmlR5RJbSCxmNU87qwafLmZBN9rYaN
+XDOFrLm1fSNfOtFTdN2ee85mzOEJoGpIoHqytnYPO2RY98q6HotCMRIO+o76BTG
ULhxVYvSEQIvQIGwUycT60eehKD7T4wb5xvzB61m/aP60SG4fQq/uH7K2dvxPU5D
mI79wh855Geu4H1NJr3rgOlyUDYnVFkUSdbWTspvif9VYsNQ2wQ=
=wS4g
-----END PGP SIGNATURE-----

--Sig_/kfDnOujsaQJS.7yl4+DvrH0--
