Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021F7DE5E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjKASPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjKASPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:15:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE01126
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:15:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3012C433C8;
        Wed,  1 Nov 2023 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698862506;
        bh=ckc4brig/10PIMBqKpo2HHz07zo8C9ezLGNHJDjitxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuRJpRqiIj8ZhYbFgPlMora2UTDgyJyT702NOd15quN3CsndS77MX+srTRzYbSSQL
         LYnAAvlHKGTr83Q3pzvOyHLFBE1G+Prykm3vg1idiT0v8SD9WAITXRLl/5vnFZKBWa
         tuWX2a1kgtGLmLoArr1el3MK/QF0/mevvr3OxTxg=
Date:   Wed, 1 Nov 2023 19:15:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH RFC 20/20] binder: delete the C implementation
Message-ID: <2023110131-slobbery-yin-72d6@gregkh>
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
 <20231101-rust-binder-v1-20-08ba9197f637@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-rust-binder-v1-20-08ba9197f637@google.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:01:50PM +0000, Alice Ryhl wrote:
> The ultimate goal of this project is to replace the C implementation.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:)

Seriously, this is all great stuff, thanks for posting it, very
impressive.  Let's see how testing goes!

greg k-h
