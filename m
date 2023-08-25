Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC3788C48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjHYPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjHYPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974DF212A;
        Fri, 25 Aug 2023 08:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3642564113;
        Fri, 25 Aug 2023 15:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D27FC433C8;
        Fri, 25 Aug 2023 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692976568;
        bh=RlUOxxL7jJQGESweP3YbxAWqflgA6jjw+4tZbwdOzfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6naCyJ8sESpKYIhGWT5mIKOf2HZgc1sqxdWuL8wGrsALz6G7CFwHDKhMxL4Cwyuu
         Bg/nHDjVJQl/B+RbkR6kKucFumf99QjQh/emosiJQ5vvFG/yF5YbpiZ7TcMbHJ5K9N
         OGfeDV2ZO3AnZwlVquWtNzUPqDRhkb8XDEN0iud/v1ccM7cAmij6qWk2dSX7f5f3OH
         EYhTnSv+NjHekDzoTuo1Kcsq5vQ2e6Wt68I1uss4ue/scbQlmlzGnVNY1ZOGJ42Qzk
         EpqOMV5w+Q9fhFAfj2aU6kesS0KnM+1p4D2wzay6q2biUUjFdyBWM5wwJCeSPv0ND+
         eas0jsxniYuhg==
Date:   Fri, 25 Aug 2023 16:16:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 06/11] firmware: imx: add driver for NXP EdgeLock
 Enclave
Message-ID: <20230825-escalate-mannish-523aa602ef36@spud>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-7-pankaj.gupta@nxp.com>
 <f7a1252f-d043-b197-6d21-2a603d928da3@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8GdQE578ZXm4nCfq"
Content-Disposition: inline
In-Reply-To: <f7a1252f-d043-b197-6d21-2a603d928da3@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GdQE578ZXm4nCfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Am 23.08.23 um 09:33 schrieb Pankaj Gupta:
> > The Edgelock Enclave , is the secure enclave embedded in the SoC
> > to support the features like HSM, SHE & V2X, using message based
> > communication channel.
> >=20
> > ELE FW communicates on a dedicated MU with application core where
> > kernel is running. It exists on specific i.MX processors. e.g.
> > i.MX8ULP, i.MX93.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:https://lore.kernel.org/oe-kbuild-all/202304120902.bP52A56z-lkp@=
intel.com
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

In passing, LKP did not report that support for your firmware was
missing, please remove the Reported-by & Closes tags.

--8GdQE578ZXm4nCfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOjFsQAKCRB4tDGHoIJi
0jc2AP0foAd3nrsjN2d+JOE229wUlQRLIr5dLjt1Osd1MSXYQwD/Ve7A/HfqFFxE
VuygqSi5LSd/ZfCtbwhAq4BGuJFSBww=
=LLDe
-----END PGP SIGNATURE-----

--8GdQE578ZXm4nCfq--
