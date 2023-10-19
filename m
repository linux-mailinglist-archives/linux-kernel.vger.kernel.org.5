Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDC7D02AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjJSTnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjJSTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:43:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4888DE8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:43:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C280C433C8;
        Thu, 19 Oct 2023 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744587;
        bh=LjrTlBbAy9tL8fyll2/yeV1R9C88AXD2Wq7hLY4tZww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WulCu3bns2V6OirFpjnFhBLuItJj8etOeHOTPQrtEPFHxVojcIEOtZX/cfSuVrQEj
         ylWzkCE4/ZcYWrgeCywov4vSrDR3SzJoU/zjgK4ZRnSm9dNvjoMIl5JthrRPHu4KUK
         I4tRz739rRAfP6x2AprydtUZEXb+rBra4u4u411fRpApTiMByNYhVPFKOoNFfP0P3A
         9alsTVaPWtvthFybyI9e7F3WTthmuFfv1AD54mbTNK/RsKDWsEeuQ85dYxBAKNsABH
         C9mmp6Tt8Vxj/iIjqq5T/7Qbh5kElvzTpt6P0QQ98evMnVdrRdvNbK4VoRqDG3qD25
         o4gzRMBDcX1fw==
Date:   Thu, 19 Oct 2023 12:43:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.6-rc7
Message-ID: <20231019124306.084dedbd@kernel.org>
In-Reply-To: <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
References: <20231019174735.1177985-1-kuba@kernel.org>
        <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 12:17:36 -0700 Linus Torvalds wrote:
> Well, it certainly sounds like *somebody* has surrounded himself with spirits.
> 
> Of the alcoholic kind.
> 
> Just _what_ does the calendar on your wall look like?  Is it maybe
> spinning or looks doubled up?

A spirit told me to burn the calendars and live by vibe :]
