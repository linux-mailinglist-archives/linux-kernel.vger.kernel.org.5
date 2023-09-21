Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111627AA363
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjIUVue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjIUVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:50:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2410D7EA2E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C107B153B;
        Thu, 21 Sep 2023 02:52:26 -0700 (PDT)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.27.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 980C13F59C;
        Thu, 21 Sep 2023 02:51:47 -0700 (PDT)
Date:   Thu, 21 Sep 2023 10:51:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com
Subject: Re: [PATCH v4 3/6] kselftest: vm: Check errnos in mdwe_test
Message-ID: <ZQwSMaRPVscyPaQI@arm.com>
References: <20230828150858.393570-1-revest@chromium.org>
 <20230828150858.393570-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828150858.393570-4-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:08:55PM +0200, Florent Revest wrote:
> Invalid prctls return a negative code and set errno. It's good practice
> to check that errno is set as expected.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
