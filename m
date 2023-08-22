Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9207840DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjHVMeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjHVMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA750196;
        Tue, 22 Aug 2023 05:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D8E64659;
        Tue, 22 Aug 2023 12:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60031C433C7;
        Tue, 22 Aug 2023 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692707661;
        bh=AhVnFhhnUOCeI76fWBEHX4+MuV9F2OXR8V+tH5qe5IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM8kRgkZhd5RkaRxzfMZUfB3n8BRcAyZBR71CeoOduJtyWKl59LyZ3SgvX+yKwENk
         o/CuH5pTkyrLtzQ1hL8oO0TwiAF7dFKA1ZsNTM363NllJ0LZFnPbDGZSx739ZdNrZ7
         1H/8Jb2MLi7qqHmlVt2xuwRg5gz0ZMcocohcqxqU=
Date:   Tue, 22 Aug 2023 14:34:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chengdong zhou <zhouscd@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <2023082211-trimming-debtor-ba00@gregkh>
References: <20230801083244.165392-1-zhouscd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801083244.165392-1-zhouscd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:32:45AM -0700, chengdong zhou wrote:
> Change function name from "source/sink" to "sourcesink".

But why?

thanks,

greg k-h
