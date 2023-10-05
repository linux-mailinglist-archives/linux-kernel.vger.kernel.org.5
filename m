Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E17BA9D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJETMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJETMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:12:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A56DCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 12:12:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A1BC433C7;
        Thu,  5 Oct 2023 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696533157;
        bh=Tw3qLeOmMTt4rHHH7mPpiRpz5PuKOiA4vb2uC+WvlSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Icl9ZnxhNZ9axTPJ3rWpt9hqEoZ+gCF3stfdVpGBe28IfMgSRmTEcD0/FFy7zNbYy
         6s5a95iVYvRJKKiymeDldptrrUTfM8XaBBYTF3yyt8uSDA24cd33VnGJ8+APELmOFd
         YYWLV/y+lDT7j7tSOEVme9yDD11LN277GErCzu0Y=
Date:   Thu, 5 Oct 2023 21:12:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] Revert "drm/amd/pm: workaround for the wrong ac
 power detection on smu 13.0.0"
Message-ID: <2023100547-vitamins-detergent-4d18@gregkh>
References: <20231005175230.232764-1-mario.limonciello@amd.com>
 <20231005175230.232764-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005175230.232764-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 12:52:30PM -0500, Mario Limonciello wrote:
> This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

No explaination as to why this needs to be reverted?  And does this need
to be backported anywhere?

thanks,

greg k-h
