Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5037B094E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjI0Pu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjI0PuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:50:09 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFB37EFB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1695829215; x=1696088415;
        bh=Sf8EpJ/Ze06akGLTx+VzhLG9yK6e28N13HnngGDh80A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=pPUCUrQ5ejL/9UgTfvM5uw+azq3xRdeFhiOSe0238hTBG0AjFbgBKH4TzFRjWkclM
         7KX4H162PJUXoS43vYHKOAO4HIS5Wr2KXTy8W7aPnsFSbpy5N2vF4avExT6eoovrSd
         Zsv5pTBUAA3Zqvjmj0t62G8PyRy8b0bv/ahn8smv2RgR71iTBDPD8f9/w5BF60UBCd
         xLxyAog6LhnpDZzKa8FQ6HfBl/EYK+1RDxfpzzQV1y4Mxg6EOieU0ID2foNSvf3f2D
         nahOKaIUdKzjAYFgu+0NII72V9ufJp5t24fntLXYwM7HOy4sn7S89FsWIcSuHEP5GQ
         RB9Z/olpJZrpA==
Date:   Wed, 27 Sep 2023 15:40:09 +0000
To:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   Turritopsis Dohrnii Teo En Ming <tdtem@protonmail.com>
Cc:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ceo@teo-en-ming-corp.com
Subject: Re: My brand new vivo V25 Pro 5G Android mobile phone is running on Linux kernel 4.19.191+
Message-ID: <BeZs4jBxhofIdjWavbuANlZ5zUrV2Wtdf9QMX5CPx_X_KT4PvKvD8c4Qc0LP_LPjKyvIy3SOjTMFgkq4xlrSKSubWZrzJLuudmSCo1Q9wLE=@protonmail.com>
In-Reply-To: <ZQzlFgJTZzTVkKeN@debian.me>
References: <P8CgyFkx_9MPXgwLiaVhdarl-IlxfJVH1voL4ttdXP0yJcLyE5nw9y537LZceOC6BkXVxzuwXjQHmeGGUDI_VbPgfDXengI-5A9ua9csUqc=@protonmail.com> <ZQzlFgJTZzTVkKeN@debian.me>
Feedback-ID: 80245632:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org






Sent with Proton Mail secure email.

------- Original Message -------
On Friday, September 22nd, 2023 at 8:51 AM, Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:


> [trimming personal and obvious political info]
>=20
> On Thu, Sep 21, 2023 at 04:20:06PM +0000, Turritopsis Dohrnii Teo En Ming=
 wrote:
>=20
> > My brand new vivo V25 Pro 5G Android mobile phone is running on Linux k=
ernel 4.19.191+. Are there any severe/critical security vulnerabilities in =
Linux kernel 4.19.191+ that will allow government-sponsored or state-backed=
 hackers or Advanced Persistent Threats (APTs) to take over absolute contro=
l of my brand new vivo mobile phone? Can I download, compile and install th=
e latest Linux kernel 6.5.4 from sources on my brand new vivo mobile phone =
by myself? I would like to know how I can do it.
>=20
>=20
> There are Android Security Bulletin listings on [1], with vivo-specific
> bulletins can be found at [2].
>=20
> For building kernels, you can follow official Android guide [3]. Or
> you can also visit XDA forums [4] where people posted their own custom
> kernels. But usually your vendor (vivo) takes care of kernel updates
> anyway.

So if I want to build the latest Linux kernel 6.5.4 for my vivo V25 Pro 5G =
mobile phone, I can follow the guides at link [3] and link [4].

>=20
> > I have decided to buy this vivo mobile phone because my Samsung Galaxy =
A32 5G mobile phone has now become extremely slow in performance and lags l=
ike hell. Maybe too many apps were installed.
>=20
>=20
> What are these apps besides built-in ones?

Besides the built-in apps, all the other apps come from Google Play Store. =
There is one exception though. The Douyin app was installed through an APK =
file and it does not come from Google Play Store.

>=20
> > Opening and using apps is now a slow and painful experience. The phone =
camera is even worse. Taking a photo or selfie takes 2-3 seconds. If you mo=
ve the phone by a bit before the 3 seconds is up, your photo or selfie will=
 turn out very blur. So you need to set a timer of 2 seconds when you take =
a selfie or photo. Taking videos with the phone camera is also very laggy a=
nd choppy. The recorded video will turn out to be choppy.
>=20
>=20
> What is your Samsung phone specification then?

My Samsung phone is the Samsung Galaxy A32 5G. The specs can be found on gs=
marena.com.

>=20
> Thanks.
>=20
> [1]: https://source.android.com/docs/security/bulletin/asb-overview
> [2]: https://www.vivo.com/en/security
> [3]: https://source.android.com/docs/setup/build/building-kernels
> [4]: https://forum.xda-developers.com
>
=20
Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
