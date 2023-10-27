Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4D7D9956
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjJ0NIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:08:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E65C2;
        Fri, 27 Oct 2023 06:08:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64CDC433C9;
        Fri, 27 Oct 2023 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698412101;
        bh=wUSE0lZzh01i6zCnbE4aWfTvei7j5EMjOcX3g2jyxM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUBPquW9x5Dbtkhk+pz89BmAhLYNFjqDU4YMrOwWzJaYlGsDWMBwBm3y54EH8MiNS
         rN/dgBYf/5MCZs0dpXF81e0Hdm/HmWfHEC7Fb1vECpbTzCZ4TIwZfTO1trxSZc6526
         4WhzrOBGOkNwGgmW3JnuRmtSci8ou/FZqxaba9FY=
Date:   Fri, 27 Oct 2023 15:08:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] samples: rust: Add USB sample bindings
Message-ID: <2023102703-rabid-dealing-7694@gregkh>
References: <20231027003504.146703-1-yakoyoku@gmail.com>
 <20231027003504.146703-3-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027003504.146703-3-yakoyoku@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:34:51PM -0300, Martin Rodriguez Reboredo wrote:
> This is a demonstration of the capabilities of doing bindings with
> subsystems that may or may not be statically linked.
> 
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
>  drivers/usb/core/Kconfig        |  7 +++++++
>  drivers/usb/core/Makefile       |  3 +++
>  drivers/usb/core/usb.rs         | 13 +++++++++++++
>  samples/rust/Kconfig            | 10 ++++++++++
>  samples/rust/Makefile           |  3 +++
>  samples/rust/rust_usb_simple.rs | 22 ++++++++++++++++++++++
>  6 files changed, 58 insertions(+)
>  create mode 100644 drivers/usb/core/usb.rs
>  create mode 100644 samples/rust/rust_usb_simple.rs
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
