Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EEC75D6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGUVnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUVnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:43:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB22D7E;
        Fri, 21 Jul 2023 14:43:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E92C7733;
        Fri, 21 Jul 2023 21:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E92C7733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689975783; bh=SNG0zXp+EBUeGzjNMD43Y/EOQIkrzPIn9fZTujaSg8I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FB2NkZC9/T9a1V6o7j6wJvmT7l/v2QuYAttIMkvp8mspnSX/86EWl9dCLqq+ubVf6
         qWnvusYrTc2PvFziP4FY2SNViWSWP0wI0NdGzxtIwXr0m3yn/3IyrVmjJ7aGPwh9AV
         5YpQpo9qIxxwt5AwOIW/Ma9pXq6mr/RVVRE1YmN3WCoNyjR9UDB2XUmEhuRlgHBXI1
         i8E43wk46C/iPPaEnJnxugZAEx2pnZb2tvGHg5TJb2+tpu632p9VpExz6amF+wc3Di
         vF1u5rEwys6UxxVPg7djNObFiG8uexjEZVT/YB0hazt7YfC8YelSifYGYkV+f4ySDW
         mCYHnx0BKEDlA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org
Cc:     jani.nikula@linux.intel.com, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, rust-for-linux@vger.kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v8 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <87mszqfbfg.fsf@meer.lwn.net>
References: <20230718151534.4067460-1-carlos.bilbao@amd.com>
 <87mszqfbfg.fsf@meer.lwn.net>
Date:   Fri, 21 Jul 2023 15:43:02 -0600
Message-ID: <87jzutaql5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Other than that one bit of strangeness, I think this is about ready to
> be applied.

...and I've just gone ahead and done that - thanks for doing this and
sticking with it!

jon
