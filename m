Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A131F7D6B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbjJYMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJYMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:17:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B71129;
        Wed, 25 Oct 2023 05:17:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D62BC433C8;
        Wed, 25 Oct 2023 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236230;
        bh=aNzjlhPZVT2WlxWs5C9sgWbPuwsbb43sfyNeFiBf4Gg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GJoFvBhUuHyR3MRvrcMf3kn9KPm9MFg1wfpEFqmGsmvvodqtarfeXe3s0FdtmHL2+
         /S3w38oS797yJVKV8uEpxaRq5avwIrDqAFfqaHRfBBqC5PRLuVdpEiP00IbgG0eeCy
         Vp4LGqu+caiaoEzCSS5OVEzdzRbNGR6aU9/oNzwevaDrs5GEdn1HJeCA2bPbxG4qPi
         m91guY+cUqvitbUjaw/rAKrHQ0XC4UKyLqaS83NVDV6HNA3YGCJrAqNh/xlkVRJtjW
         kLoW30792dtkpV8UGeyQHUCMxyOhq4H84mIhuUcM0mJWeOdxIzMLTltAlOEd2/FGG7
         C6dGUgQQ7R8JA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231003152927.15000-5-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <20231003152927.15000-5-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 4/5] spmi: document spmi_device_from_of()
 refcounting
Message-Id: <169823622809.724579.15259798363513831386.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 13:17:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 17:29:26 +0200, Johan Hovold wrote:
> Add a comment documenting that the spmi_device_from_of() takes a
> reference to the embedded struct device that needs to be dropped after
> use.
> 
> 

Applied, thanks!

[4/5] spmi: document spmi_device_from_of() refcounting
      commit: 7db72c01ae2359dbab29f4a60cda49757cf84516

--
Lee Jones [李琼斯]

