Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE67B789B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjJDHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJDHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:21:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D48AC;
        Wed,  4 Oct 2023 00:21:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C08C433C7;
        Wed,  4 Oct 2023 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696404100;
        bh=HDkujlQX+Fd+q+bpEeqrxXaxiuZCSkTikHvTxLJ6Xpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQjDTGNQmSQlRdTeUpgIFabxrbg6CHOL/TkSN1ku0VqA/pt9OZr2FQFQtiDJ4oagF
         mqQFsNKssJAfBvXOAZ2Iq3/9Kd879Tb668qEYmyktiQ1y6hntU35OjDfVbfkMLlJFi
         Exzzjs6E69qFVl958sLmQ+dKDRocU+WciW+HIQwg=
Date:   Wed, 4 Oct 2023 09:21:37 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Woo-kwang Lee <wookwang.lee@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sj1557.seo@samsung.com
Subject: Re: [PATCH] usb: core: add bos NULL pointer checking condition
Message-ID: <2023100411-duckling-tibia-398a@gregkh>
References: <CGME20231004062700epcas1p16fe36bf6b6a6e5d9d4adeaef32937480@epcas1p1.samsung.com>
 <20231004062642.16431-1-wookwang.lee@samsung.com>
 <2023100439-king-salute-5cd5@gregkh>
 <000101d9f691$4513da00$cf3b8e00$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d9f691$4513da00$cf3b8e00$@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 04:06:17PM +0900, Woo-kwang Lee wrote:
> Hello. I think I missed the patch.

I do not understand, does that mean that you have tested the patch (and
which one, please do not top post), and that this is not needed?

confused,
greg k-h
