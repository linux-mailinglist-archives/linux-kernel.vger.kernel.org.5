Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE497CE592
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjJRR5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjJRR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:57:13 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4EC12B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1697651829; x=1697911029;
        bh=qg1FOCAW/ZNkhfLQUnB0m1HTCb5NKmRZ0oWQUjY7kLg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dRboJLM1CQ7qc7Ug/4scXZzoRb9hNkHsaj9XBRiea/xBLmykdWwbhiKlXU76Dejed
         VgYNU5sYzH4B9vsaN5hdD4+d+lAh80rnEv6cz39rsAKQmutnyzTZ4mtBY/lP3o2c/5
         vUHggxRe6+ySvwT4+bhYAsZK2PHJDNsi7kBzDrq8EfjyngIrpl9HeeMCt9lcIhJxev
         +hQvHB2F4xYhF5QNit1eV/3papqbnSyhxlERLL64JKpA/WMaAj8MPsg0+f3RXGEOJb
         TcHo76ycjFm4JWw85xzXPrnec1QDUpdtkZ937skpFLg6OgKAyFIknAuF8GfLopu0Ol
         ZrzHtuXnwUdqg==
Date:   Wed, 18 Oct 2023 17:56:52 +0000
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
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 2/2] kbuild: remove old Rust docs output path
Message-ID: <c-GFV2p1lETIN6czmE3f0YFrusVTJ6kuiZXx_UA3FC_f6ORK3uGdQ5z_mCxLVkg4xktI79_Df3f-bTwhHUfzocoKJ8Go5TR4GRlcKxxMrrA=@proton.me>
In-Reply-To: <20231018160145.1017340-2-ojeda@kernel.org>
References: <20231018160145.1017340-1-ojeda@kernel.org> <20231018160145.1017340-2-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.23 18:01, Miguel Ojeda wrote:
> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`. The `make cleandocs` target
> takes care of cleaning it now since it is integrated with the rest
> of the documentation.
>=20
> Thus remove the old reference.
>=20
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno
