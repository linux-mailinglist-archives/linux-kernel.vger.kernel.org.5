Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A437C91E3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjJNAtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJNAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:49:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E979BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:49:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C00C433C8;
        Sat, 14 Oct 2023 00:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697244558;
        bh=1OuDIBPSP56OUSXV6qWm3oIscqloJHF80yZOdxmXzzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EziUhmAKbTqpkwuYG9l0nluYQyRN5FLIl8ERSAF/+UAIC4Qrr7Zg2xRWfIfDgaooC
         ak5pNzXgNN188KkL3x9sT3rNO7u3bEKeG5LAq1N8gmJU2yjOALjiZz0vxc/GdKKNoJ
         F+xp9r3T8waq1mRDkesG48rXy4srH5KKOsfOf0pxak8AzSingxvngivCP+AETQ+UP2
         x4snNRPgNRy9rswMi/LCQbMMSpfMsfsgzuEr71o3Lag/wrPy0DwQ2u2iygbPIJg8Et
         t3/ThcvKgLjWGqNcZFEi33HnqoWSMb64M6sk3/L2riBcOFaxA2FalS9Tvr8famcvTT
         VVkM98ZvAIiVw==
Date:   Fri, 13 Oct 2023 17:49:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jesper Juhl <jesperjuhl76@gmail.com>
Subject: Re: [PATCH net 2/2] MAINTAINERS: Remove linuxwwan@intel.com mailing
 list
Message-ID: <20231013174916.40707d19@kernel.org>
In-Reply-To: <20231013014010.18338-3-bagasdotme@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
        <20231013014010.18338-3-bagasdotme@gmail.com>
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

On Fri, 13 Oct 2023 08:40:09 +0700 Bagas Sanjaya wrote:
> Messages submitted to the ML bounce (address not found error). In
> fact, the ML was mistagged as person maintainer instead of mailing
> list.

Johannes, no chance we can get someone to help with IOSM?
