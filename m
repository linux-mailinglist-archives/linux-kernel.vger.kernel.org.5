Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91F7BF39E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442384AbjJJHDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442267AbjJJHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:03:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7067492
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC21C433C7;
        Tue, 10 Oct 2023 07:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696921379;
        bh=75DdSpD2VdSaKLW4DBCxIc0yNGSCKNe0WtGpPASdFUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocfjkqSw5UhrFExVbB/qCdabDvK3hXfbI9ZvtF8ZmrDCGX7pORVvDqUpQ/VturcjG
         iTCQwgdY8MNG64+aKGBL5Dnr9AGoDjCGRg3kuk0LAFx4+SxfAwB3Y4ZHn7tEzC7Kfk
         IPfNhujurIY8oMO6WEkRnCKU3kSVyj/EkCLq6Q00=
Date:   Tue, 10 Oct 2023 09:02:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 00/14] Add TPS25750 USB type-C PD controller support
Message-ID: <2023101017-custard-scale-470f@gregkh>
References: <20231003155842.57313-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003155842.57313-1-alkuor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:58:33AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>

Note, your subject line says 00/14 yet your patches had 00/09.  I hope
you didn't dropp patches somewhere?

I applied what is here now, but are some missing?

thanks,

greg k-h
