Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8355A755E87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGQIcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGQIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B289D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E2D60FC6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44651C433C7;
        Mon, 17 Jul 2023 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689582766;
        bh=nVdNFaIM5q8yzAM6X+ufMIbwtpAWzqwx9TWlj/9T9a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJv8zaXTCskf0rsUA2PcHM5wmjcsMNCwOxRXctje0xqR6ITX+/19lybW3LQiEkOik
         MpIy+cALmr5EXeHLBSIOU8eiUXQwB3FWADGAd6R5wGWmBYs/oAQNSF6WijrWD9s8XF
         qOh4yZlrywBH8R5UmZF6jaJjLi4bm5efVj13pMjdwK5Ns63+4gM/ocZ1lHT8Umcv1C
         5PLma2w6djzqVpWBX2ItlXsp6K4hXtbCG4a2P63f6QMBv4iE6yiMkYOrMqLkJmVWOi
         8zep+sMwzjH91JwjqeHWZ0crB752mKET/bAXqnLjCriTu/wWU92hbW5dDoZTO36fiz
         DlGaVHBJ9gQ+Q==
Date:   Mon, 17 Jul 2023 10:32:44 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, afd@ti.com,
        hns@goldelico.com, matthew.brost@intel.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, dakr@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/17] arm64: dts: ti: k3-am62-main: Add GPU device
 node [DO NOT MERGE]
Message-ID: <el4ythd7inzj5emscuoiewh4x2glkyugxxnqd67axloglamtpr@vp26mlv6ocas>
References: <20230714143033.112624-1-sarah.walker@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfri3en37qva4g6l"
Content-Disposition: inline
In-Reply-To: <20230714143033.112624-1-sarah.walker@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfri3en37qva4g6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 14, 2023 at 03:30:33PM +0100, Sarah Walker wrote:
> Add the Series AXE GPU node to the AM62 device tree.
>=20
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>

Checkpatch complains about that one because you indented the node with
spaces instead of tabs.

Once fixed:
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--mfri3en37qva4g6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLT8qwAKCRDj7w1vZxhR
xa7fAP9FDt6bwQ/W8zycfYaWUKZ/M9LdF98tonOYw0cebZEB8gD/aOmlzvHgQ9FI
LdvGl02SvojJp3fIySEVUOc3xWUX5Aw=
=6+yl
-----END PGP SIGNATURE-----

--mfri3en37qva4g6l--
