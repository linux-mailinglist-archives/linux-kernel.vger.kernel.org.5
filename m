Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA877DDC9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjKAG2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKAG2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:28:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B32107
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:27:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE4AC433C8;
        Wed,  1 Nov 2023 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698820078;
        bh=hWj52DqnsXqb5POx3jc5q4axMzxAP+iO7/r/1npSns0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0ASN1CV/lVQ/UVVq0Ss710e2SSzCVJKTBACASlNto4Jkh+hq+4wB7S84aOJt0oGg
         xpYFePECBRbZvOL7TQyp3Yir18or3O1xwud621Oz7IecW0RTw3i+5SDOxABuRTGOCt
         sNNBeql5Q4uPrVqus31/6F20fEjYiDiGXkruqWNs=
Date:   Wed, 1 Nov 2023 07:27:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naveen Kumar M <mnkumar@google.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, royluo@google.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: host: xhci-plat: Add quirk-no-64-bit-support
Message-ID: <2023110138-dill-aloof-c1a9@gregkh>
References: <20231031044021.1162403-1-mnkumar@google.com>
 <20231031044021.1162403-2-mnkumar@google.com>
 <CA+Hc5+6Zb65gL1tCOZ6bYQThVn3HFS_gzj+_P+y-TkrHKw6zbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Hc5+6Zb65gL1tCOZ6bYQThVn3HFS_gzj+_P+y-TkrHKw6zbw@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:13:08AM +0530, Naveen Kumar M wrote:
> Adding the reviewers/maintainers I missed in the previous mail to this patch

That's not going to work, please resend a new series, and please, do not
top-post.

thanks,

greg k-h
