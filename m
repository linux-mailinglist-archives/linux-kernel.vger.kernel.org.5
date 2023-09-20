Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672857A835B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjITN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjITN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:27:41 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35CDC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=nkaeb2utyrh3nl4swsopnmkpdy.protonmail; t=1695216448; x=1695475648;
        bh=OINTYFYxCoZe1tYbRyK/mU8Nic5sesmAXoDsL+AwPOc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hKMlNSYlPnZVEHXg6mMj4dX7SORVY6s+fOJDjk3TE5kNkq6aPiqL/jssf2N/bxm0j
         Ce39X+hvJzWnKjgSjcQoVPjdAYe0c65Z1lvcLygchDrniJ4a3Lx5372j3lF1dF/AzQ
         W4o5dWckFH9hNNLmGvedt4OtVAn+nMxwpNLKJ97lx2woiYpGoaN0UdThYxM34lB5Y7
         8d6y908DLHt9NY7tXoTrqjtI3a90PQMjCy+zZofhhZlj9VBoaOMR6741PBIi7c9DTc
         M9UCMuJrbHGbfqAWzEpCy0kjCMaBhUBKFVfV08vXFa6J5gjHUWfj/0pnC2woG0GpYR
         xLaBH+3FeU9Uw==
Date:   Wed, 20 Sep 2023 13:27:10 +0000
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
Message-ID: <98bd4aa8-acde-5831-6137-be0afef3aef7@proton.me>
In-Reply-To: <20230830165949.127475-1-ojeda@kernel.org>
References: <20230830165949.127475-1-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.23 18:59, Miguel Ojeda wrote:
> A few months ago we started a webpage for the Rust subsystem and
> the overall Rust for Linux project [1].
>=20
> The current `W:` field of the Rust entry points to the GitHub
> repository, since originally we kept information in a `README.md`
> file that got rendered by GitHub when visiting that URL.
>=20
> That information was moved into the webpage and got expanded.
> The webpage is also nowadays the entry point to the project,
> and we pointed the "Website" GitHub metadata field to it.
>=20
> Thus update the `W:` field to point to the actual webpage.
>=20
> Link: https://rust-for-linux.com [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12601a47c839..7c8088e9a11b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18558,7 +18558,7 @@ R:=09Andreas Hindborg <a.hindborg@samsung.com>
>   R:=09Alice Ryhl <aliceryhl@google.com>
>   L:=09rust-for-linux@vger.kernel.org
>   S:=09Supported
> -W:=09https://github.com/Rust-for-Linux/linux
> +W:=09https://rust-for-linux.com
>   B:=09https://github.com/Rust-for-Linux/linux/issues
>   C:=09zulip://rust-for-linux.zulipchat.com
>   T:=09git https://github.com/Rust-for-Linux/linux.git rust-next
>=20
> base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
> --
> 2.42.0
>=20

Reviewed-by: Benno Lossin <benno.lossin@proton.me>


