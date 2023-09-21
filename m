Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6937AA38A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjIUVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjIUVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:52:27 -0400
Received: from gimli.kloenk.dev (gimli.kloenk.dev [49.12.72.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5CA250;
        Thu, 21 Sep 2023 14:47:13 -0700 (PDT)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1695332829; bh=dibhVPJvQaXwsPDV+JZyg3dOQIzNC4VBUKFGV6Vi5fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G1RsT7gNdsmNaemGoEwV2kSzt8p0vWCPiuy+qGtD+EZPcIMj/1ANFF7GTY0xlEFPW
         +uhqBM6wYSFeGFknIPfYRWNdstQkAxasCJ7NazGfnqYLvpTICAUxr31dqV+6tcYTEG
         KOlu7+W9pNwkLLTy75iilAIowP1vvKBzdruucOE0=
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 1/2] rust: arc: rename `ArcInner` to `WithRef`
Date:   Thu, 21 Sep 2023 23:47:07 +0200
Message-ID: <5B67E427-E65F-4DC3-9520-FBD8ADBBB6DC@kloenk.dev>
In-Reply-To: <20230921213440.202017-2-wedsonaf@gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com>
 <20230921213440.202017-2-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Sep 2023, at 23:34, Wedson Almeida Filho wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This is in preparation for removing `ArcBorrow` and making `WithRef`
> public.
>
> This is a pure name change with no functional changes intended.
>
> Suggested-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---

Reviewed-by: Finn Behrens <me@kloenk.dev>
