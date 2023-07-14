Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E475434C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbjGNTif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbjGNTid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:38:33 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1273A95;
        Fri, 14 Jul 2023 12:38:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E20205BF;
        Fri, 14 Jul 2023 19:38:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E20205BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689363512; bh=kd7l8uQjKXWQlkgfloaGJY937UoSw+kMU7u2OIGadVM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ijLOPzmfJwOrS8DSC6AD9vLtI2bPScV1IX5qCV0vClQmwstZfil50AMVmT9IBp2jK
         I4EMWkUzchEmsuf7JuMoOvMQINVWJpTuKVLlBFmk1Mw/rbBZ5ZW6yfz+tOj2JCz1QU
         xylZfdY9xPadTDl58ACUTOkwFwVfT2iArn+lW7Fxs+X5K+mIB44gCquWSfvyxSZYRV
         6DMmy+67qbVSVOzL2pIYpvbbraQ+mlUvesl6VxkJjJ0Y+ENzHDtMCYbFl574+TmKw9
         7eZp3Br6VSaSIlervmePW1s31peBgAknpoXnVBmhKtgZmxQOTybR4qseXB5jHE5i6Y
         kr1ZpuI/136PA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: consolidate core subsystems
In-Reply-To: <20230622071004.2934698-1-costa.shul@redhat.com>
References: <20230622071004.2934698-1-costa.shul@redhat.com>
Date:   Fri, 14 Jul 2023 13:38:31 -0600
Message-ID: <871qhaz3k8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make the page more organized as requested
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Applied, thanks.

jon
