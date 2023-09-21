Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC17AA594
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjIUXZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjIUXZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:25:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE886107
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E527C4E74E;
        Thu, 21 Sep 2023 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695304834;
        bh=HbA5iULXyLPFf2bFXoU3dpV8WI5kxu+YFc1N4jF1L2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw+SRjXWQEWTEo/iafrfQz8VkQqZ0QyOu2X1ObLsbb+33KbxHPtYkVAgNvlOdiyzA
         eBYjlMX+xp8eCOGuK6QUBHjlzhTyGcDh9FYMvRJiALBxwTN8NmTj64MAYaetVFn44B
         9fnzT97R/GeaRHgZ42Z8dFYu9xAoKkRrS5bBXA1D+TH+C44Ew3oZ+fVD5j+qRC6R7k
         VFwmV73p9uNrsucNeb16quOQ7gL4OmKlGUVp7abKhNZ+ZjF1vmcyo6xxVUDQ0C4gjn
         HdDs7o27OFH4YMjP4J7QmBiNH0RY7I85P+XSOmwNn/CdQV5oG0aLqQWZeCiuyFM7dI
         fxhvAj7FncohQ==
Date:   Thu, 21 Sep 2023 15:00:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
Message-ID: <20230921-slot-goal-c03ac4f0db90@spud>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-arrival-bonanza-e335686420f4@wendy>
 <CAHAQgRDh72FLQPOFzn2rhsWmOOaLUO0sKyJwJQBG0Z7qZN_YLw@mail.gmail.com>
 <20230921-1ae70cfdbf983e011d5b6754@fedora>
 <CAHAQgRBFje4mdhE3dZZH=HxED0bUauXBD4yNfQzEnpPSWG5HiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="muk+u1lqGbjyw/DQ"
Content-Disposition: inline
In-Reply-To: <CAHAQgRBFje4mdhE3dZZH=HxED0bUauXBD4yNfQzEnpPSWG5HiA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--muk+u1lqGbjyw/DQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 21, 2023 at 09:51:58PM +0800, Chen Wang wrote:

> Conor, do you want me to add you to the MAINTAINERS entry too?

Nope, no need. My existing maintainers entries should cover it.

Thanks,
Conor.

--muk+u1lqGbjyw/DQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQxMfQAKCRB4tDGHoIJi
0syUAP4h+gobTYujuawwrF9fvZg3Qn3BF9VaVT5NH2iBnApl5wD+POJWMSSetJWO
NynHZ9xJ51y2szVWwB1MvQmuoRah3gk=
=1ks/
-----END PGP SIGNATURE-----

--muk+u1lqGbjyw/DQ--
