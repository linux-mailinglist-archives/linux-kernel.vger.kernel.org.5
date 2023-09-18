Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071C17A46A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjIRKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbjIRKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:05:02 -0400
Received: from out-211.mta0.migadu.com (out-211.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440E19A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:04:18 -0700 (PDT)
Message-ID: <beb29fd4-bfd1-3f4f-abfa-59f901bff09b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695031456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBtaFBrw04FMiCMwTM459ytb/rG57ta7e9Bo9pDP9XQ=;
        b=FPJZLDTI3msIfsS1LYKiNg/B+uB6YAJCQ8t4hP9gPD+zVX4nfUtlLvOzPeo+v501NBwtTu
        ifc6pHBOe4g9nx98O0dl0KS+1ZFRnBdQAjTiPMMxtRisEHeIvtbtIXJDFHBnqHqdLEdxsF
        IyCBBF6w/IZCEmv5sGfXDNtWMRAo0yQ=
Date:   Mon, 18 Sep 2023 11:04:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] Documentation fixes for dpll subsystem
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
References: <20230918093240.29824-1-bagasdotme@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230918093240.29824-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 10:32, Bagas Sanjaya wrote:
> First of all, sorry for not reviewing dpll series [1] before it gets merged. I
> was prompted to post this doc fixup mini series because I was emailed by kernel
> test robot (see [1/2] for the warnings).
> 
> This fixup is all code block related.

Thanks for cleaning the documentation part.

Vadim

