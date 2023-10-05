Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6532B7BAEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjJEWXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:23:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DEF95;
        Thu,  5 Oct 2023 15:23:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0527C433CB;
        Thu,  5 Oct 2023 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696544627;
        bh=k01278ZqF2ArLbrRINqUwrP4EslDkp7gz0fkp1gCeHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i4D4XBIZSz6aDvGQLfjqgEfKxgVZDvn3/4s6LoXI9s7272919YuGStEXUP9Sv+vcC
         T3mtGlkbO8f6vAKRmL7n+PkocGyFHKcQiCTaL0hf//7/njk9jeax0Rp1vnTBoLLaGD
         gWjH68RHkYoYjG67zvhvwNo99lU2mxIulB0UYcZ4LmUkCWdWfj2ubV0gM0CJ2dNQuZ
         QaX4/iRxlMHRB5SAFt0y5CGVuLQj0N1WGRsCB2rbfpWsaJjkiwj3jtAo6kRD1R+BkG
         D/TZKAhP+MKhov5HWyLuecUVVTjVVYw9yQi2gHx/K84ugiQKZW+3XvXH4JM8JD0oxh
         hKTtgX68oj5ow==
Date:   Thu, 5 Oct 2023 17:23:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20231005222345.GA797815@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006090540.2ed5f123@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:05:40AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   3731355b37a3 ("PCI: endpoint: Use IS_ERR_OR_NULL() helper function")
> 
> is missing a Signed-off-by from its committer.

Fixed, sorry.
