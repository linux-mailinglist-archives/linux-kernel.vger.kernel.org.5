Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3078DF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjH3T1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbjH3SDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:03:13 -0400
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 11:03:07 PDT
Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338A193;
        Wed, 30 Aug 2023 11:03:07 -0700 (PDT)
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
        by hop.stappers.nl (Postfix) with ESMTP id B300D20167;
        Wed, 30 Aug 2023 17:53:10 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id 471A430417C; Wed, 30 Aug 2023 19:53:10 +0200 (CEST)
Date:   Wed, 30 Aug 2023 19:53:09 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
Message-ID: <ZO+CBdxxuDBrdDR8@gpm.stappers.nl>
References: <20230830165949.127475-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830165949.127475-1-ojeda@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:59:48PM +0200, Miguel Ojeda wrote:
> A few months ago we started a webpage for the Rust subsystem and
> the overall Rust for Linux project [1].
> 
> The current `W:` field of the Rust entry points to the GitHub
> repository, since originally we kept information in a `README.md`
> file that got rendered by GitHub when visiting that URL.
> 
> That information was moved into the webpage and got expanded.

It looks like "mdbook" and "webbrowser view-source" confirms it is.


> The webpage is also nowadays the entry point to the project,
> and we pointed the "Website" GitHub metadata field to it.
> 
> Thus update the `W:` field to point to the actual webpage.
> 
> Link: https://rust-for-linux.com [1]

Where to find the source for the MarkDownBook?


> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12601a47c839..7c8088e9a11b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18558,7 +18558,7 @@ R:	Andreas Hindborg <a.hindborg@samsung.com>
>  R:	Alice Ryhl <aliceryhl@google.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
> -W:	https://github.com/Rust-for-Linux/linux
> +W:	https://rust-for-linux.com
>  B:	https://github.com/Rust-for-Linux/linux/issues
>  C:	zulip://rust-for-linux.zulipchat.com
>  T:	git https://github.com/Rust-for-Linux/linux.git rust-next
> 
> base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
> -- 
> 2.42.0

Reviewed-by: Geert Stappers <stappers@stappers.nl>


Groeten
Geert Stappers
-- 
Silence is hard to parse
