Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64497A97B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjIUR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjIUR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99431BCE;
        Thu, 21 Sep 2023 10:01:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AB6C433BC;
        Thu, 21 Sep 2023 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695281463;
        bh=MMiANpm/tYrygvqzjXfEiCYC2yeCEyBRWQiNI0+pzFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z0PHmHygjWP1wKwlpRSiugrczCcpHcj8QTlBqQn/HoTurjSMHGHImFbMpzAGGnOL9
         YT7saeq1G0DMNq0uo/d+YQ+cgPIcRb83YfVEymFdMCD/KgRs9hah3CtyoZA3QQ+wSb
         Ax7Vfn6w7iOOiMmU5A4lkYNoV2Qdz+exHkWVCm+Q=
Date:   Thu, 21 Sep 2023 09:31:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Message-ID: <2023092152-unfilled-spinout-657c@gregkh>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:10:27PM +0200, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its type
> definition from 8250 code. As with previous removals, I checked with
> Debian Code Search that 'PORT_AR7' is not used in userspace.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
