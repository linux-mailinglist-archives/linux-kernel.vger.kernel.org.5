Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216B78758E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbjHXQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbjHXQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7491198;
        Thu, 24 Aug 2023 09:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D650673A2;
        Thu, 24 Aug 2023 16:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21138C433C8;
        Thu, 24 Aug 2023 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692895105;
        bh=7R2mvuEZmSt/0ZkAzdJIROp/ZSpNB4MHh0SyypYt6mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSxz1KZpMoSCWQ91+86Z4jQPCQlxYEJ0281UqxRF+Cb4ZhlUlfeyDJziC8buAlGba
         UBjXg6jaChnOEZ73RE8sXwANjZwaiNeJeCkI2xEsU83jI+FDm8tF5Xao0HMO5b8Db5
         M3wKfD4Ujgoiec+4zUtZezg+VtSu4nBY+UCnLUWU=
Date:   Thu, 24 Aug 2023 18:38:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.191-rc1 review
Message-ID: <2023082438-voucher-disobey-c591@gregkh>
References: <20230824145027.008282920@linuxfoundation.org>
 <e722f48c-2032-8898-84ed-994a4457c62b@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e722f48c-2032-8898-84ed-994a4457c62b@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:05:35PM +0300, Alexey Khoroshilov wrote:
> On 24.08.2023 17:49, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.191 release.
> 
> Do you mean 5.10.192 release?

Ah crap, this is what happens when I come back from a long trip where I
was working on my laptop and I didn't fully sync my desktop.

Yes, you are right, I am behind a release here, let me go update my
trees and push out a new -rc for this, thanks for catching it.

greg k-h
