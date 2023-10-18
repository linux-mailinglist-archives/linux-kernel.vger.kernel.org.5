Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587D7CE56D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJRR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjJRR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:56:14 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE2116;
        Wed, 18 Oct 2023 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=id5jhg4t6jh75dlqjp6pot5zcy.protonmail; t=1697651770; x=1697910970;
        bh=+Do60tFHTgD/yzVC6yohA+Xb+DeuzbVb/pyouLR43hE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LXdbYs+nAy09u7e3TbPcQo2fVpqLTtG1rOME0Ve16ipPFbaG1XVeNxSqmsqek1QpU
         ErMTgCXBfV2e57cG3V0+htGeydsqb/fk135HE00P7rjfFyJwrN8kvFLsLiT2wxDG9b
         HM4sK8FUsKPR2SQpWoNG1m1Ynp0BgeO8Tf2O9p+EHY1zU37qIRPBeVvhA1kzvIjgpf
         Tmy1VMw8JggmdrPRLfkewxHrp8cWxnRIP6VI28yuyBgt1RYShb4Joc3HkoX7QlIVfG
         tBPP8Lr0PItp1Z3KVJDNmLyg2JErVyhC9fQTmcGbOmuhuEdMCHeFAnxYL/YrJ8ISLW
         ogx2NOXKEKIPA==
Date:   Wed, 18 Oct 2023 17:55:59 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH 1/2] docs: rust: update Rust docs output path
Message-ID: <9zPimFJ-VQdlvUz-8ChRRxxHCJviKOt0uoclPqJzpAL9t_1s7NoPnTzCcHC-0XAbWKoRK_VLIN_duiv09Zrb0EW2rixLUv0cbxBIy6GsG_w=@proton.me>
In-Reply-To: <20231018160145.1017340-1-ojeda@kernel.org>
References: <20231018160145.1017340-1-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.23 18:01, Miguel Ojeda wrote:
> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`, thus update the old reference.
>=20
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno
